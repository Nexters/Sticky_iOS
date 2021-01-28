//
//  LocationManager.swift
//  Sticky
//
//  Created by deo on 2021/01/23.
//

import Combine
import CoreLocation
import Foundation
import MapKit

// MARK: - LocationManager

class LocationManager: NSObject, ObservableObject {
    // MARK: Lifecycle

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.activityType = .otherNavigation
        self.locationManager.showsBackgroundLocationIndicator = true
        self.locationManager.requestLocation()
    }

    // MARK: Internal

    let objectWillChange = PassthroughSubject<Void, Never>()
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5173209, longitude: 127.0473887),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )

    @Published var status: CLAuthorizationStatus? {
        willSet { self.objectWillChange.send() }
    }

    @Published var location = CLLocation() {
        willSet { self.objectWillChange.send() }
    }

    @Published var placemark: CLPlacemark? {
        willSet { self.objectWillChange.send() }
    }

    // MARK: Private

    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
}

// MARK: CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        self.status = status
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else {
            print("변경된 location이 없습니다")
            return
        }
        self.location = location
        self.region.center = CLLocationCoordinate2D(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }

    /// 영역 모니터링 시작할 때
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Start monitoring: \(self.region.center)")
    }

    /** 영역을 들어갔을 때
     챌린지 종료 카운트다운 초기화
     */
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Enter: \(self.region.center)")
    }

    /** 영역을 벗어났을 때
     - 현재 집이 아니므로 챌린지를 시작할 수 없음
     - 현재 위치에서 벗어남을 감지하고 n초 후 챌린지 종료 카운트 다운 및 경고
     */
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exit: \(self.region.center)")
    }

    /** 현재 위치를 지오펜싱으로 영역 처리
     */
    func setGeofenceMyHome(region: MKCoordinateRegion) {
        let geofence = CLCircularRegion(
            center: region.center,
            radius: 100, // 100m
            identifier: "MyHomeRegion"
        )
        geofence.notifyOnExit = true
        geofence.notifyOnEntry = true
        self.locationManager.startMonitoring(for: geofence)
    }
}

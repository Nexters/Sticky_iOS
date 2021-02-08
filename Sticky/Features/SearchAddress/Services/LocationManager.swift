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
import UserNotifications

// MARK: - LocationManager

class LocationManager: NSObject, ObservableObject {
    // MARK: Lifecycle

    override init() {
        super.init()

        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestLocation()
        self.locationManager.allowsBackgroundLocationUpdates = true
//        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.activityType = .other
//        self.locationManager.showsBackgroundLocationIndicator = false
        self.notificationCenter.delegate = self

        self.notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if granted {
                // 항상인지 체크해야함
                print("NotificationCenter Authorization Granted!")
            }
        }
    }

    // MARK: Internal

    let notificationCenter = UNUserNotificationCenter.current()
    let objectWillChange = PassthroughSubject<Void, Never>()
    @Published var region: MKCoordinateRegion?
//    MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.5173209, longitude: 127.0473887),
//        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//    )
    @Published var isAlways: Bool = false

    var geofence: CLCircularRegion? {
        willSet {
            if newValue!.contains(self.location.coordinate), !(self.geofence?.contains(self.location.coordinate) ?? false) {
                // newValue내에 존재 && 이전Value내에 존재하지 X
                NotificationCenter.default.post(name: .enterGeofence, object: nil)
            } else if !newValue!.contains(self.location.coordinate), self.geofence?.contains(self.location.coordinate) ?? false {
                NotificationCenter.default.post(name: .exitGeofence, object: nil)
            }
        }
    }

    @Published var status: CLAuthorizationStatus? {
        willSet { self.objectWillChange.send() }
    }

    @Published var location = CLLocation() {
        willSet {
            print("location update")
            self.objectWillChange.send()
        }
    }

    @Published var placemark: CLPlacemark? {
        willSet { self.objectWillChange.send() }
    }

    func isContains() -> Bool {
//        locationManager.requestLocation()
        return (self.geofence?.contains(self.location.coordinate) ?? true)
    }

    func setNotPause() {
        self.locationManager.pausesLocationUpdatesAutomatically = false
    }

    func restartManager() {
        print("Restart LocationManager")
        guard let geofence = self.geofence else { return }
        self.locationManager.stopMonitoring(for: geofence)
        self.locationManager.startMonitoring(for: geofence)
    }

    // 위치 권한이 항상인지 체크
    func checkLocationStatus() -> Bool {
        if self.locationManager.authorizationStatus == .authorizedAlways {
            self.isAlways = true
        } else {
            self.isAlways = false
        }
        return self.isAlways
    }

    // MARK: Private

    private var flag: Int = 0
    private let locationManager = CLLocationManager()
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
        self.region?.center = CLLocationCoordinate2D(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }

    /// 영역 모니터링 시작할 때
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Start monitoring: \(self.geofence?.center)")
        self.setGeofenceMyHome(region: self.region!)
    }

    /** 영역을 들어갔을 때
     챌린지 종료 카운트다운 초기화
     */
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Enter: \(self.geofence?.center)")
        NotificationCenter.default.post(name: .enterGeofence, object: nil)
    }

    /** 영역을 벗어났을 때
     - 현재 집이 아니므로 챌린지를 시작할 수 없음
     - 현재 위치에서 벗어남을 감지하고 n초 후 챌린지 종료 카운트 다운 및 경고
     */
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exit: \(self.geofence?.center)")
        NotificationCenter.default.post(name: .exitGeofence, object: nil)
    }

    /** 현재 위치를 지오펜싱으로 영역 처리
     */
    func setGeofenceMyHome(region: MKCoordinateRegion) {
        let _geofenceExit = CLCircularRegion(
            center: region.center,
            radius: 100, // 100m
            identifier: "MyHomeRegion1"
        )

        _geofenceExit.notifyOnExit = true
        _geofenceExit.notifyOnEntry = true
        self.geofence = _geofenceExit
        scheduleNotification_exit(region: _geofenceExit)
//        self.locationManager.startMonitoring(for: _geofenceExit)
    }
}

// MARK: UNUserNotificationCenterDelegate

extension LocationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {}

    func scheduleNotification_enter(region: CLCircularRegion) {
        print("asd")
        let center = UNUserNotificationCenter.current()

        center.removeAllPendingNotificationRequests() // deletes pending scheduled notifications, there is a schedule limit qty

        let content = UNMutableNotificationContent()
        content.title = "들어감"
        content.body = "Run! This zone is dangerous! :o"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default

        // Ex. Trigger within a timeInterval
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        self.notificationCenter.add(request)
    }

    func scheduleNotification_exit(region: CLCircularRegion) {
        print("asd")
        let center = UNUserNotificationCenter.current()

        center.removeAllPendingNotificationRequests() // deletes pending scheduled notifications, there is a schedule limit qty

        let content = UNMutableNotificationContent()
        content.title = "나가기"
        content.body = "Run! This zone is dangerous! :o"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound.default

        // Ex. Trigger within a timeInterval
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        self.notificationCenter.add(request)
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.list, .badge, .sound])
    }
}

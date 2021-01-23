//
//  LocationViewModel.swift
//  Sticky
//
//  Created by deo on 2021/01/23.
//

import Combine
import CoreLocation
import Foundation
import MapKit

class LocationViewModel: NSObject, ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868),
        span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    )
    private let locationManager = CLLocationManager()

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
    }
}

// location manager delegate extension
extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        print(location)
        self.region.center = CLLocationCoordinate2D(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }
}

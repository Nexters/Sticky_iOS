//
//  Location.swift
//  Sticky
//
//  Created by deo on 2021/01/30.
//
import CoreLocation
import Foundation

// MARK: - Location

class Location: ObservableObject {
    // MARK: Internal

    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var title: String = "알 수 없음"
    @Published var subtitle: String = "알 수 없음"

    func geocode(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        self.geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                print("something went horribly wrong")
            }

            if let placemarks = placemarks {
                if let placemark = placemarks.first {
                    print(placemark)
                    self.title = placemark.name ?? "알 수 없음"
                    self.subtitle = placemark.getAddress()
                }
            }
        }
    }

    // MARK: Private

    private var geocoder = CLGeocoder()
}

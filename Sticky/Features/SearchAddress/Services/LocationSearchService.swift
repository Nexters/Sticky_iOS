//
//  LocationSearchService.swift
//  Sticky
//
//  Created by deo on 2021/01/24.
//

import Combine
import Foundation
import MapKit
import SwiftUI

// MARK: - LocationSearchService

class LocationSearchService: NSObject, ObservableObject {
    // MARK: Lifecycle

    override init() {
        self.completer = MKLocalSearchCompleter()
        super.init()
        self.cancellable = $searchQuery.assign(
            to: \.queryFragment,
            on: self.completer
        )
        self.completer.delegate = self
    }

    // MARK: Internal

    @Published var searchQuery: String = ""
    @Published var completions: [MKLocalSearchCompletion] = []
    @Published var placemark: CLPlacemark?
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5173209, longitude: 127.0473887),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )

    var cancellable: AnyCancellable?
    var completer: MKLocalSearchCompleter
}

// MARK: MKLocalSearchCompleterDelegate

extension LocationSearchService: MKLocalSearchCompleterDelegate {
    func getLocation(completion: MKLocalSearchCompletion) {
        let search = MKLocalSearch(request: MKLocalSearch.Request(completion: completion))
        search.start { response, _ in
            guard let response = response else { return }

            for item in response.mapItems {
                if let location = item.placemark.location {
                    self.placemark = item.placemark
                    self.region = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: location.coordinate.latitude,
                            longitude: location.coordinate.longitude
                        ),
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.005,
                            longitudeDelta: 0.005
                        )
                    )
                }
            }
        }
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.completions = completer.results
    }
}

// MARK: - MKLocalSearchCompletion + Identifiable

extension MKLocalSearchCompletion: Identifiable {}

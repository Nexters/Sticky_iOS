//
//  CLPlacemark+.swift
//  Sticky
//
//  Created by deo on 2021/01/30.
//

import CoreLocation
import Foundation

extension CLPlacemark {
    func getAddress() -> String {
        return [subThoroughfare, thoroughfare, locality, administrativeArea, postalCode, country]
            .flatMap { $0 }
            .joined(separator: " ")
    }
}

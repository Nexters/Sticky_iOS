//
//  Map.swift
//  Sticky
//
//  Created by deo on 2021/01/20.
//

import MapKit
import SwiftUI

// MARK: - MapCard

struct MapCard: View {
    // MARK: Internal

    var body: some View {
        MapView(centerCoordinate: $centerCoordinate)
            .frame(width: 280, height: 210)
            .cornerRadius(24)
            .overlay(
                Circle()
                    .fill(Color.main)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
            )
    }

    // MARK: Private

    @State private var centerCoordinate = CLLocationCoordinate2D()
}

// MARK: - Map_Previews

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        MapCard()
    }
}

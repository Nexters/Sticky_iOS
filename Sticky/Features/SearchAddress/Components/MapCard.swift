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

    @State var pinUp: Bool = false
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        let mapView = MapView(centerCoordinate: $centerCoordinate, pinUp: $pinUp)
        mapView
            .frame(width: width, height: height)
            .cornerRadius(24)
            .overlay(
                ZStack {
                    Circle()
                        .fill(Color.Palette.primary)
                        .opacity(0.3)
                        .frame(width: 32, height: 32)
                    Image(systemName: "pin.fill")
                        .foregroundColor(Color.red)
                        .offset(y: self.pinUp ? -20 : -10)
                        .animation(.easeIn(duration: 0.5))
                }
            )
    }

    // MARK: Private

    @State private var centerCoordinate = CLLocationCoordinate2D()
}

// MARK: - Map_Previews

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        MapCard(width: 296, height: 216)
            .environmentObject(Location())
            .environmentObject(LocationManager())
    }
}

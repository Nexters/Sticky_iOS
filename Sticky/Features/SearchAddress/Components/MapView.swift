//
//  MapView.swift
//  Sticky
//
//  Created by deo on 2021/01/30.
//

import MapKit
import SwiftUI

// MARK: - MapView

struct MapView: UIViewRepresentable {
    @EnvironmentObject var location: Location
    @EnvironmentObject var locationManager: LocationManager
    // 지도를 움직일 때 가운데 좌표
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var pinUp: Bool

    var isFirst = true
    var mapView = MKMapView()

    func makeUIView(context: Context) -> MKMapView {
        mapView.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            ),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - Coordinator

class Coordinator: NSObject, MKMapViewDelegate {
    // MARK: Lifecycle

    init(_ parent: MapView) {
        self.parent = parent
    }

    // MARK: Internal

    var parent: MapView

    /// 지도의 가운데가 변할 때 마다 (지도를 드래그할 때마다)
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        parent.centerCoordinate = mapView.centerCoordinate
    }

    /// 지도 드래그 시작 시
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
//        if parent.location.locationType == .drag {
//            parent.location.title = "위치 선택 중"
//            parent.location.subtitle = "드래그를 멈추면 위치를 검색합니다"
//        }
        parent.pinUp.toggle()
    }

    /// 지도 드래그 멈춤 시 콜백
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if !parent.isFirst {
            parent.location.geocode(
                latitude: parent.centerCoordinate.latitude,
                longitude: parent.centerCoordinate.longitude
            )
        }
        parent.isFirst = false
        parent.pinUp.toggle()
    }
}

// MARK: - MapView_Previews

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(
            centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
            pinUp: .constant(false)
        )
        .environmentObject(Location())
        .environmentObject(LocationManager())
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

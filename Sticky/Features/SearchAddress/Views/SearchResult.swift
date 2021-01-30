//
//  SearchResult.swift
//  Sticky
//
//  Created by deo on 2021/01/20.
//

import MapKit
import SwiftUI

// MARK: - SearchResult

struct SearchResult: View {
    // MARK: Internal

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @EnvironmentObject var location: Location
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var locationSearchService: LocationSearchService

    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            NavigationLink(destination: Main(), tag: "main", selection: $selection) { EmptyView() }
            VStack {
                MapCard()
                    .padding(.bottom, 30)

                Text("\(location.title)")
                    .font(.system(size: 24))
                    .bold()
                    .padding(.bottom, 8)

                Text("\(location.subtitle)")
                    .font(.system(size: 16))
                    .padding(.bottom, 46)
                Button(action: {
                    locationManager.setGeofenceMyHome(region: MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                    ))
                    let hasGeofence = UserDefaults.standard.bool(forKey: "hasGeofence")
                    UserDefaults.standard.setValue(true, forKey: "hasGeofence")

                    if hasGeofence {
                        print("집 주소를 변경했습니다")
                        self.rootPresentationMode.wrappedValue.dismiss()
                    } else {
                        print("집 주소를 등록했습니다")
                        self.selection = "main"
                    }

                }) {
                    GradientRoundedButton(
                        content: "집으로 설정하기".localized,
                        startColor: Color.black,
                        endColor: Color.black,
                        width: 202,
                        height: 48
                    )
                    .padding(.bottom, 20)
                }

                Button(action: focusRelease) {
                    Text("여기가 아닌가요?")
                        .foregroundColor(.white)
                        .underline()
                }
            }
            .padding(.leading, 24)
            .padding(.trailing, 24)
            .foregroundColor(.white)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: backButton)
        }
    }

    var backButton: some View {
        Button(action: focusRelease) {
            HStack {
                Image("left-arrow")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        }
    }

    func focusRelease() {
        self.presentationMode.wrappedValue.dismiss()
    }

    // MARK: Private

    @State private var selection: String?
}

// MARK: - SearchResult_Previews

struct SearchResult_Previews: PreviewProvider {
    static var previews: some View {
        SearchResult()
            .environmentObject(LocationManager())
    }
}

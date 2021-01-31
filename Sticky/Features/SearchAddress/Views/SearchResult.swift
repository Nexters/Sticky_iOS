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
            NavigationLink(destination: Main(), tag: "main", selection: $selection) { EmptyView() }
            VStack {
                MapCard(width: 296, height: 216)
                    .padding(.bottom, 30)

                Text("\(location.title)")
                    .font(.system(size: 24))
                    .bold()
                    .padding(.bottom, 8)

                Text("\(location.subtitle)")
                    .font(.system(size: 16))
                    .padding(.bottom, 46)
                Text("이후에 주소를 수정하면 모든 기록이 초기화됩니다.")
                    .font(.system(size: 14))
                    .foregroundColor(Color.GrayScale._500)
                    .padding(.bottom, 8)
                Button(action: setHome) {
                    GradientRoundedButton(
                        content: "집으로 설정하기".localized,
                        startColor: Color.Palette.primary,
                        endColor: Color.Palette.primary,
                        width: 296,
                        height: 60,
                        cornerRadius: 24
                    )
                }.padding(.bottom, 16)

                Button(action: focusRelease) {
                    Text("여기가 아닌가요?")
                        .font(.system(size: 17))
                        .underline()
                        .foregroundColor(Color.Palette.primary)
                }
            }
            .padding(.horizontal, 32)
            .foregroundColor(.black)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: backButton)
        }
    }

    func setHome() {
        locationManager.setGeofenceMyHome(region: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        ))
        let hasGeofence = UserDefaults.standard.bool(forKey: "hasGeofence")
        UserDefaults.standard.setValue(true, forKey: "hasGeofence")

        if hasGeofence {
            print("집 주소를 변경했습니다")
            rootPresentationMode.wrappedValue.dismiss()
        } else {
            print("집 주소를 등록했습니다")
            selection = "main"
        }
    }

    var backButton: some View {
        Button(action: focusRelease) {
            HStack {
                Image("back")
                    .aspectRatio(contentMode: .fit)
            }
        }
    }

    func focusRelease() {
        presentationMode.wrappedValue.dismiss()
    }

    // MARK: Private

    @State private var selection: String?
}

// MARK: - SearchResult_Previews

struct SearchResult_Previews: PreviewProvider {
    static var previews: some View {
        SearchResult()
            .environmentObject(LocationManager())
            .environmentObject(Location())
            .environmentObject(LocationSearchService())
    }
}

//
//  SearchAddress.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import MapKit
import SwiftUI

// MARK: - SearchAddress

struct SearchAddress: View {
    // MARK: Internal

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var locationSearchService: LocationSearchService
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var location: Location

    var body: some View {
        VStack {
            ZStack {
                Color.main
                    .ignoresSafeArea()

                VStack {
                    Text("집 주소를 입력해주세요")
                        .font(.system(size: 28))
                        .bold()
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: 36,
                            alignment: .leading
                        )
                        .padding(.bottom, 16)
                    EditText(
                        input: $locationSearchService.searchQuery,
                        placeholder: "도로명, 건물명 또는 지번으로 검색",
                        accentColor: .white
                    )
                    .padding(.bottom, 30)
                    NavigationLink("", destination: SearchResult(), isActive: self.$isActive)
                    Button(action: {
                        self.isActive = true
                        let coordinate = self.locationManager.location.coordinate
                        self.location.latitude = coordinate.latitude
                        self.location.longitude = coordinate.longitude
                    }) {
                        BorderRoundedButton(
                            text: "현재 위치로 주소 찾기",
                            borderWidth: 2.0,
                            borderColor: Color.gray200,
                            fontColor: .white,
                            icon: "ic_here"
                        )
                    }
                }
                .padding(.horizontal, 16)
            }.frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 257,
                maxHeight: 257,
                alignment: .center
            )
            .foregroundColor(.white)

            if locationSearchService.searchQuery.count == 0 {
                Tip().padding(.top, 20)
            } else {
                if locationSearchService.completions.count > 0 {
                    List(locationSearchService.completions) { completion in
                        Button(action: {
                            locationSearchService.getLocation(completion: completion)
                            let coordinate = locationSearchService.region.center
                            self.location.latitude = coordinate.latitude
                            self.location.longitude = coordinate.longitude
                            self.location.title = completion.title
                            self.location.subtitle = completion.subtitle
                            self.isActive = true
                        }) {
                            VStack(alignment: .leading) {
                                Text(completion.title)
                                Text(completion.subtitle)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .frame(minHeight: 100)
                    .padding(.top, 20)
                } else {
                    NotFound().padding(.top, 20)
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
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

    @State private var isActive = false
}

// MARK: - SearchAddress_Previews

struct SearchAddress_Previews: PreviewProvider {
    static var previews: some View {
        SearchAddress()
    }
}

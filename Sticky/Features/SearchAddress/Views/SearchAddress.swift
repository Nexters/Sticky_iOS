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
        ZStack {
            NavigationLink(destination: SearchResult(), isActive: self.$isActive) { EmptyView() }
            Color.white
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("집 주소를 입력해주세요")
                        .foregroundColor(Color.black)
                        .font(.system(size: 28))
                        .bold()
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: 36,
                            alignment: .leading
                        )
                        .padding(.vertical, 16)

                    EditText(
                        input: $locationSearchService.searchQuery,
                        placeholder:
                        "도로명, 건물명 또는 지번으로 검색",
                        accentColor: .white
                    )
                    .padding(.bottom, 8)

                    Button(action: {
                        self.isActive = true
                        let coordinate = self.locationManager.location.coordinate
                        self.location.latitude = coordinate.latitude
                        self.location.longitude = coordinate.longitude
                    }) {
                        BorderRoundedButton(
                            text: "현재 위치로 주소 찾기",
                            borderWidth: 2.0,
                            borderColor: Color.Border.primary,
                            fontColor: Color.TextIconLight.primary,
                            icon: "here",
                            cornerRadius: 16.0
                        )
                    }
                    .frame(height: 48)

                }.padding(.horizontal, 16)

                Divider().padding(.top, 16)

                VStack {
                    if locationSearchService.searchQuery.isEmpty {
                        Tip()
                            .padding(.top, 16)
                    } else {
                        if !locationSearchService.completions.isEmpty {
                            ScrollView {
                                // List에서는 RowInsets로 좌우 패딩이 안지워지므로 ForEach 사용
                                VStack(alignment: .leading) {
                                    ForEach(locationSearchService.completions) {
                                        completion in
                                        Button(action: { searchByCompletion(completion: completion) }) {
                                            VStack(alignment: .leading) {
                                                Text(completion.title)
                                                    .kerning(-0.3)
                                                    .font(.system(size: 17))
                                                    .padding(.bottom, 2)
                                                Text(completion.subtitle)
                                                    .kerning(-0.3)
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.gray)
                                            }
                                            .foregroundColor(.black)
                                            .padding(.vertical, 12)
                                        }
                                        .padding(.horizontal, 0)
                                        Divider()
                                            .padding(.horizontal, 0)
                                    }
                                }
                            }
                            .frame(minHeight: 100)
                        } else {
                            NotFound()
                        }
                    }
                }.padding(.horizontal, 16)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .navigationBarTitle("", displayMode: .inline)
    }

    var backButton: some View {
        Button(action: focusRelease) {
            HStack {
                Image("back")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
        }
    }

    func searchByCompletion(completion: MKLocalSearchCompletion) {
        self.locationSearchService.getLocation(completion: completion)
        let coordinate = self.locationSearchService.region.center
        self.location.latitude = coordinate.latitude
        self.location.longitude = coordinate.longitude
        self.location.title = completion.title
        self.location.subtitle = completion.subtitle
        self.isActive = true
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
            .environmentObject(LocationSearchService())
            .environmentObject(Location())
            .environmentObject(LocationManager())
    }
}

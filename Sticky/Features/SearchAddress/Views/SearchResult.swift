//
//  SearchResult.swift
//  Sticky
//
//  Created by deo on 2021/01/20.
//

import SwiftUI

// MARK: - SearchResult

struct SearchResult: View {
    // MARK: Internal

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var model: LocationManager
    @EnvironmentObject var locationSearchService: LocationSearchService

    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            NavigationLink(destination: Timer(), tag: "timer", selection: $selection) { EmptyView() }
            VStack {
                MapCard()
                    .padding(.bottom, 30)

                Text("\(locationSearchService.placemark?.name ?? "알 수 없음")")
                    .font(.system(size: 24))
                    .bold()
                    .padding(.bottom, 8)

                Text("\(locationSearchService.placemark?.thoroughfare ?? "알 수 없음")")
                    .font(.system(size: 16))
                    .padding(.bottom, 46)
                Button(action: {
                    model.setGeofenceMyHome(region: locationSearchService.region)
                    self.selection = "timer"
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

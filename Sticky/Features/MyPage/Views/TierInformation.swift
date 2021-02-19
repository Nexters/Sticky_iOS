//
//  TierInformation.swift
//  Sticky
//
//  Created by deo on 2021/02/06.
//

import SwiftUI

// MARK: - TierInformation

/// 등급정보 화면
struct TierInformation: View {
    // MARK: Internal

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var imageName = ""

    var body: some View {
        ScrollView(.vertical) {
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
        .onAppear {
            print(Locale.current.regionCode)
            if Locale.current.regionCode == "KR" {
                imageName = "level_info_KR"
            } else {
                imageName = "level_info_EN"
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .navigationBarTitle("등급정보", displayMode: .inline)
        .navigationBarColor(UIColor.white, textColor: UIColor.black)
    }

    // MARK: Private

    private var backButton: some View {
        Button(action: focusRelease) {
            HStack {
                Image("back")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
        }
    }

    private func focusRelease() {
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - TierInformation_Previews

struct TierInformation_Previews: PreviewProvider {
    static var previews: some View {
        TierInformation()
    }
}

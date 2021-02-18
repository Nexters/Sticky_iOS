//
//  LicenseView.swift
//  Sticky
//
//  Created by 지현우 on 2021/02/18.
//

import SwiftUI

// MARK: - LicenseView

struct LicenseView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("Lottie-iOS")
                    .font(.custom("Modak", size: 40))
                Spacer()
                    .frame(height: 20)
                Text(LottieLicense.title)
                    .bold()
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 20)
                Text(LottieLicense.description)
            }
            .padding(.horizontal, 12)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .navigationBarTitle("라이센스", displayMode: .inline)
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

    func focusRelease() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - LicenseView_Previews

struct LicenseView_Previews: PreviewProvider {
    static var previews: some View {
        LicenseView()
    }
}

//
//  LocationPermission.swift
//  Sticky
//
//  Created by deo on 2021/01/31.
//

import SwiftUI

// MARK: - LocationPermission

struct LocationPermission: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("bg_map")
                    .resizable()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                VStack {
                    Spacer()
                    Text("Sticky")
                        .font(.custom("Modak", size: 40))
                        .foregroundColor(Color.Palette.primary)
                    Image("pin_and_character")
                        .resizable()
                        .frame(width: 108, height: 225)
                        .padding(.top, 28)
                    Text("Sticky를 사용하기 위해 위치정보 설정을 항상으로 변경해주세요.")
                        .font(.custom("AppleSDGothicNeo-Bold", size: 17))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top, 32)

                    NavigationLink(destination: SearchAddress()) {
                        GradientRoundedButton(
                            content: "위치정보 설정하기".localized,
                            startColor: Color.Palette.primary,
                            endColor: Color.Palette.primary,
                            width: 180,
                            height: 48,
                            cornerRadius: 16.0
                        )
                    }.padding(.top, 24)
                    Spacer()
                }.padding(.horizontal, 48)
            }
        }.edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
    }
}

// MARK: - LocationPermission_Previews

struct LocationPermission_Previews: PreviewProvider {
    static var previews: some View {
        LocationPermission()
    }
}

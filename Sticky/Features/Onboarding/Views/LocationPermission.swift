//
//  LocationPermission.swift
//  Sticky
//
//  Created by deo on 2021/01/31.
//

import SwiftUI

// MARK: - LocationPermission

struct LocationPermission: View {
    @EnvironmentObject var locationManager: LocationManager
    @State var isAlways: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("bg_map")
                    .resizable()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Image("logo-blue")
                        .resizable()
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/,
                               minHeight: 0, maxHeight: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/,
                               alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
                        .scaledToFit()

                    Text("""
                        집콕 시간 측정을 위해 위치 정보 설정을
                        "항상"으로 변경해주세요
                        """
                    )
                    .font(.custom("AppleSDGothicNeo-Bold", size: 17))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                    Text("설정 > 위치 > 항상")
                        .foregroundColor(Color.GrayScale._700)
                        .font(.custom("AppleSDGothicNeo", size: 14))
                        .padding(.top, 12)

                    NavigationLink(destination: Onboarding(type: 0), isActive: $isAlways) {
                        EmptyView()
                    }
                    Button(action: {
                        checkLocationStatus()
                    }, label: {
                        GradientRoundedButton(
                            content: "위치정보 설정하기",
                            startColor: Color.Palette.primary,
                            endColor: Color.Palette.primary,
                            width: 180,
                            height: 48,
                            cornerRadius: 16.0
                        )
                    }).padding(.top, 40)

                    Spacer()
                    Spacer()
                }
                .padding(.horizontal, 48)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
    
    private func checkLocationStatus(){
        if !locationManager.checkLocationStatus() {
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: { _ in
                    if locationManager.checkLocationStatus() {
                        isAlways = true
                    } else {
                        isAlways = false
                    }
                })
            }
        }else{
            isAlways = true
        }
    }
}

// MARK: - LocationPermission_Previews

struct LocationPermission_Previews: PreviewProvider {
    static var previews: some View {
        LocationPermission()
    }
}

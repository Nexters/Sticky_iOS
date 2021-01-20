//
//  Onboarding.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import SwiftUI

struct Onboarding: View {
    init() {
        let newNavAppearance = UINavigationBarAppearance()
        newNavAppearance.configureWithTransparentBackground()
        newNavAppearance.backgroundColor = .clear
        UINavigationBar.appearance()
            .standardAppearance = newNavAppearance
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.main
                    .ignoresSafeArea()
                VStack {
                    Image("logo_sticky")
                        .padding(.bottom, 40)
                    Text("“Sticky”는 집에서 사용하는 챌린지 서비스입니다. 집 위치를 설정하기 위해 위치정보 사용을 동의해주세요!".localized)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 280, height: 72)
                        .padding(.bottom, 50)

                    NavigationLink(destination: SearchAddress()) {
                        GradientRoundedButton(
                            content: "위치정보 설정하기".localized,
                            startColor: Color.black,
                            endColor: Color.black,
                            width: 202,
                            height: 48
                        )
                    }
                }.frame(width: 280, height: 290)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: Onboarding())
    }
}

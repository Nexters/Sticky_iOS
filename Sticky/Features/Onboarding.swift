//
//  Onboarding.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Sticky")
                    .font(Font.custom("Nunito", size: 24))
                    .bold()
                    .padding(.bottom, 32)

                Circle()
                    .frame(width: 264, height: 264)
                    .foregroundColor(Color.gray100)

                Text("스티키는 집에서만 이용할 수 있어요,\n주소 정보는 소중하게 지켜진답니다.".localized)
                    .frame(width: 312, height: 48)
                    .padding(.top)
                    .padding(.bottom, 40)

                Indicator(currentIndex: 0)
                    .padding(.bottom, 56)

                NavigationLink(destination: SearchAddress()) {
                    GradientRoundedButton(
                        content: "시작하기".localized,
                        startColor: Color.gradientStart,
                        endColor: Color.gradientEnd,
                        width: 312,
                        height: 48
                    )
                }
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: Onboarding())
    }
}

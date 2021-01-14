//
//  Onboarding.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        VStack {
            Spacer()

            Text("Sticky")
                .font(Font.custom("Nunito", size: 24))
                .bold()
                .padding(.bottom, 32)

            Circle()
                .frame(width: 264, height: 264)
                .foregroundColor(Color.tempColor)

            Text("스티키는 집에서만 이용할 수 있어요,\n주소 정보는 소중하게 지켜진답니다.".localized)
                .frame(width: 312, height: 48)
                .padding(.top)
                .padding(.bottom, 40)

            IndicatorView(currentIndex: 0)

            Spacer()

            ZStack {
                Rectangle()
                    .frame(width: 312, height: 48)
                    .foregroundColor(.clear)
                    .background(Color.gradientHorizontal)
                Text("시작하기")
                    .foregroundColor(.white)
                    .bold()
            }.cornerRadius(24)
        }
    }
}

struct IndicatorView: View {
    var currentIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0 ..< 3, id: \.self) { index in
                Circle()
                    .frame(width: index == self.currentIndex ? 10 : 8,
                           height: index == self.currentIndex ? 10 : 8)
                    .foregroundColor(index == self.currentIndex ? Color.blue : .gray)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .padding(.bottom, 8)
                    .animation(.spring())
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}

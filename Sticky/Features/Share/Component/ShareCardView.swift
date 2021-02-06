//
//  ShareCardView.swift
//  Sticky
//
//  Created by deo on 2021/02/01.
//

import SwiftUI

// MARK: - ShareCardView

/// 카드 한 장 짜리 공유 컴포넌트
struct ShareCardView: View {
    var image: String
    var title: String
    var description: String

    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .frame(width: 264, height: 364)
            .foregroundColor(.white)
            .shadow(color: Color.black.opacity(0.16), radius: 20, x: 0, y: 4)
            .overlay(
                VStack {
                    Image(image)
                        .resizable()
                        .frame(width: 160, height: 160)
                        .padding(.top, 28)
                    Text(title)
                        .font(.custom("Modak", size: 28))
                        .frame(width: 232, height: 32)
                        .padding(.horizontal, 8)
                    Text(description)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                        .frame(width: 224)
                    Spacer()
                    Text("sticky")
                        .font(.custom("Modak", size: 16))
                        .foregroundColor(.gray)
                        .opacity(2.0)
                        .padding(.bottom, 20)
                }
            )
    }
}

// MARK: - ShareCardView_Previews

struct ShareCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Sticky.blue_bg.ignoresSafeArea()
            ShareCardView(image: "sticky", title: "몰까요", description: "글쎼요")
        }
    }
}

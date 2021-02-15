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
        GeometryReader { gr in
            RoundedRectangle(cornerRadius: 40)
                .foregroundColor(.white)
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
                .onReceive(NotificationCenter.default.publisher(for: .captureScreen), perform: { noti in
                    guard let color = noti.userInfo?["bgColor"] as? LinearGradient else { return }
                    saveInPhoto(img: captureWithBG(origin: gr.frame(in: .global).origin, size: gr.size, bgColor: color))

                })
                .onReceive(NotificationCenter.default.publisher(for: .shareLocal), perform: { noti in
                    guard let color = noti.userInfo?["bgColor"] as? LinearGradient else { return }

                    shareLocal(image: captureWithBG(origin: gr.frame(in: .global).origin, size: gr.size, bgColor: color))

                })
                .onReceive(NotificationCenter.default.publisher(for: .shareInstagram), perform: { noti in
                    guard let color = noti.userInfo?["bgColor"] as? LinearGradient else { return }
                    shareInstagram(
                        bgImage: captureBGImage(origin: gr.frame(in: .global).origin, size: gr.size, bgColor: color),
                        cardImage: captureCardImage(origin: gr.frame(in: .global).origin, size: gr.size)
                    )

                })
        }
        .frame(width: 264, height: 364)
        .shadow(color: Color.black.opacity(0.16), radius: 4, x: 0, y: 4)
    }
}

// MARK: - ShareCardView_Previews

struct ShareCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Sticky.blue_bg.ignoresSafeArea()
            ShareCardView(image: "level1", title: "몰까요", description: "글쎼요")
        }
    }
}

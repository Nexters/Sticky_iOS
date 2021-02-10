//
//  BannerItemDetail.swift
//  Sticky
//
//  Created by deo on 2021/02/11.
//

import SwiftUI

// MARK: - BannerItemDetail

struct BannerItemDetail: View {
    @Binding var isPresented: Bool
    var badge: Badge

    var body: some View {
        ZStack {
            Color.black.opacity(0.6).ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: 264, height: 368)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.16), radius: 20, x: 0, y: 4)
                    .overlay(
                        VStack {
                            Image(badge.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 160, height: 160)
                                .padding(.top, 28)
                            Text(badge.name)
                                .kerning(-0.3)
                                .font(.custom("Modak", size: 28))
                                .frame(width: 232, height: 32)
                                .padding(.horizontal, 8)
                            Text(badge.description)
                                .kerning(-0.3)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .frame(width: 224)
                            Spacer()
                            Text("stikky")
                                .font(.custom("Modak", size: 16))
                                .foregroundColor(.gray)
                                .opacity(2.0)
                                .padding(.bottom, 20)
                        }
                    )
                Button(action: { self.isPresented = false }) {
                    RoundedRectangle(cornerRadius: 16)
                        .overlay(
                            Image("close")
                        )
                        .foregroundColor(Color.white)
                        .frame(width: 48, height: 48)
                        .padding(.top, 32)
                }
            }
        }
    }
}

// MARK: - BannerItemDetail_Previews

struct BannerItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BannerItemDetail(
                isPresented: .constant(true),
                badge: Badge(badgeType: BadgeType.monthly, badgeValue: "30", _name: "")
            )
//            image: "monthly_30_locked",
//            title: "30 Hours",
//            description: "한달 동안 집에서 보낸 시간\n30시간을 달성하면 받을 수 있습니다."
        }
    }
}

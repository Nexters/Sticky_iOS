//
//  BannerItem.swift
//  Sticky
//
//  Created by deo on 2021/01/31.
//

import SwiftUI

// MARK: - BannerItem

struct BannerItem: View {
    var image: String
    var title: String
    var subtitle: String
    var width: CGFloat = 190
    var height: CGFloat = 60
    var bgColor = Color.TextIconColor.secondary

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12).foregroundColor(bgColor)
            HStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .frame(width: 44, height: 44)
                VStack(alignment: .leading) {
                    Text("\(title)")
                        .font(.system(size: 17))
                        .bold()
                    Text("\(subtitle)")
                        .kerning(-0.3)
                        .font(.system(size: 14))
                        .lineLimit(2)
                }
                Spacer()
            }.padding(.all, 8)
        }.frame(width: width, height: height)
    }
}

// MARK: - BannerItem_Previews

struct BannerItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.GrayScale._900.ignoresSafeArea()
            BannerItem(
                image: "",
                title: "제목제목제목제목제목제목",
                subtitle: "부제목부제목부제목부제목부제목부제목"
            )
        }
    }
}

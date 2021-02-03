//
//  BadgeItem.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

// MARK: - BadgeItem

struct BadgeItem: View {
    var badge: String
    var title: String
    var date: String
    @Binding var selection: String?

    var body: some View {
        Button(action: { selection = "share" }) {
            VStack {
                ZStack {
                    Image(badge)
                        .frame(width: 79, height: 79)
                        .foregroundColor(Color.Palette.negative)
                }
                .frame(width: 99, height: 99)

                Text("\(title)")
                    .font(.system(size: 17))
                    .bold()
                    .padding(.top, 6)
                Text("\(date)")
                    .font(.system(size: 14))
                    .foregroundColor(Color.GrayScale._500)
                    .padding(.top, 4)
            }
        }.foregroundColor(.black)
    }
}

// MARK: - BadgeItem_Previews

struct BadgeItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BadgeItem(
                badge: "badge_monthly_10_received",
                title: "Badge Name",
                date: "2021.01.22",
                selection: .constant("share")
            )
        }
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}

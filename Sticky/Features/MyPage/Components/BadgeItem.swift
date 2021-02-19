//
//  BadgeItem.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

// MARK: - BadgeItem

struct BadgeItem: View {
    var badge: Badge
    @Binding var selection: ShareType?
    @Binding var showCountBadge: Bool
    @StateObject var shareViewModel: ShareViewModel

    var body: some View {
        Button(action: {
            if badge.active {
                selection = ShareType.card
                shareViewModel.badge = badge
            }
        }) {
            VStack {
                ZStack {
                    Image(badge.image)
                        .frame(width: 79, height: 79)
                        .foregroundColor(Color.Palette.negative)
                    ZStack {
                        Circle()
                            .foregroundColor(.black)
                        Text("\(badge.count > 9 ? "9+" : String(badge.count))")
                            .bold()
                            .foregroundColor(.white)
                            .font(Font.system(size: 12))
                    }
                    .isHidden(!showCountBadge)
                    .frame(width: 24, height: 24)
                    .offset(x: 30, y: -35)
                    .opacity(1.0)
                }
                .frame(width: 99, height: 99)

                Text("\(badge.name)")
                    .font(.system(size: 17))
                    .bold()
                    .padding(.top, 6)
                Text("\(badge.updated?.toString() ?? "")")
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
                badge: Badge(badgeType: BadgeType.monthly, badgeValue: "10"),
                selection: .constant(ShareType.card),
                showCountBadge: .constant(true),
                shareViewModel: ShareViewModel()
            )
        }
        .environmentObject(ShareViewModel())
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}

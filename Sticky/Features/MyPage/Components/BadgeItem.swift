//
//  BadgeItem.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

struct BadgeItem: View {
    var title: String
    var date: String

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 79, height: 79)
                    .foregroundColor(Color.pink64)
            }
            .frame(width: 99, height: 99)

            Text("\(title)")
            Text("\(date)")
                .foregroundColor(Color.gray88)
        }
    }
}

struct BadgeItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BadgeItem(title: "Badge Name", date: "2021.01.22")
        }
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}

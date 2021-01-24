//
//  BadgePanel.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

struct BadgePanel: View {
    var leading: String = ""
    var trailing: String = ""
    var badges: [Badge]?
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        VStack {
            HStack {
                if !leading.isEmpty {
                    Text("\(leading)")
                        .font(.system(size: 16))
                        .bold()
                }
                Spacer()
                if !trailing.isEmpty {
                    Text("\(trailing)")
                        .font(.system(size: 16))
                }
            }

            LazyVGrid(columns: columns) {
                ForEach(badges!, id: \.self) { badge in
                    BadgeItem(title: badge.name, date: badge.updated.toString())
                }
            }
        }
    }
}

struct BadgePanel_Previews: PreviewProvider {
    static var previews: some View {
        BadgePanel(leading: "누적 달성", trailing: "이번 달", badges: badgeMocks)
            .padding()
    }
}

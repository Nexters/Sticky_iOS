//
//  BadgePanel.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

// MARK: - BadgePanel

struct BadgePanel: View {
    // MARK: Internal

    var leading: String = ""
    var trailing: String = ""
    var badges: [Badge]?
    @Binding var selection: String?

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
                    BadgeItem(
                        title: badge.name,
                        date: badge.updated.toString(),
                        selection: $selection
                    )
                }
            }
        }
    }

    // MARK: Private

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
}

// MARK: - BadgePanel_Previews

struct BadgePanel_Previews: PreviewProvider {
    static var previews: some View {
        BadgePanel(leading: "누적 달성", trailing: "이번 달", badges: badgeMocks, selection: .constant("share"))
            .padding()
    }
}

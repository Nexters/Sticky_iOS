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

    var title: String = ""
    var subtitle: String = ""
    var trailing: AnyView?
    var badges: [Badge]?
    @Binding var selection: ShareType?

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    if !title.isEmpty {
                        Text("\(title)")
                            .font(.system(size: 16))
                            .bold()
                    }
                    if !subtitle.isEmpty {
                        Text("\(subtitle)")
                            .foregroundColor(Color.GrayScale._500)
                            .font(.system(size: 14))
                    }
                }
                Spacer()
                trailing
            }

            LazyVGrid(columns: columns) {
                ForEach(badges!, id: \.self) { badge in
                    BadgeItem(
                        badge: badge,
                        selection: $selection
                    )
                }
            }
            Divider()
                .padding(.top, 16)
                .padding(.bottom, 24)
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
        BadgePanel(title: "누적 달성", subtitle: "누적주적", trailing: AnyView(Text("이번 달")), badges: badgeMocks(count: 6), selection: .constant(ShareType.card))
            .padding()
    }
}

//
//  CardItem.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/20.
//

import SwiftUI

// 각 카드 정보가 담기는 UI 뷰
struct CardItem<Content: View>: View {
    @EnvironmentObject var UIState: UIStateModel
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    var id: Int
    var content: Content

    @inlinable public init(
        id: Int,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        cardHeight: CGFloat,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2)
        self.cardHeight = cardHeight
        self.id = id
    }

    var body: some View {
        content
            .frame(width: cardWidth, height: id == UIState.activeCard ? cardHeight : cardHeight - 60, alignment: .center)
    }
}

struct CardItem_Previews: PreviewProvider {
    static var previews: some View {
        let items = [
            Card(id: 0, name: "Hey"),
            Card(id: 1, name: "Ho"),
            Card(id: 2, name: "Lets"),
            Card(id: 3, name: "Go")
        ]
        return ForEach(items, id: \.self.id) { item in
            CardItem(
                // 카드 UI의 id
                id: Int(item.id),
                // 카드 사이의 너비
                spacing: 16,
                // 가려진 카드의 너비
                widthOfHiddenCards: 20,
                // 카드의 높이
                cardHeight: 500
            ) {
                Text("\(item.name)")
            }
            .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(8)
            .shadow(color: Color.gray, radius: 4, x: 0, y: 4)
            .transition(AnyTransition.slide)
            .animation(.spring())
            .environmentObject(UIStateModel())
        }
    }
}

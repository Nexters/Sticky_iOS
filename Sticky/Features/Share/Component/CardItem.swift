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
        cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2)
        self.cardHeight = cardHeight
        self.id = id
    }

    var body: some View {
        // Active 카드인지 확인
        // Active 카드가 아닌 카드들은 여기서 UI/Design 수정
        content
            .frame(width: cardWidth, height: id == UIState.activeCard ? cardHeight : cardHeight - 60, alignment: .center)
    }
}

struct CardItem_Previews: PreviewProvider {
    static var previews: some View {
        let items = [
            Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
            Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
            Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
        ]
        return ForEach(items, id: \.self.id) { item in
            CardItem(
                // 카드 UI의 id
                id: Int(item.id),
                // 카드 사이의 너비
                spacing: 20,
                // 가려진 카드의 너비
                widthOfHiddenCards: 40,
                // 카드의 높이
                cardHeight: 360
            ) {
                Text("\(item.nickname)")
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

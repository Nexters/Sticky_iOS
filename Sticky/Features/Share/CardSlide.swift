//
//  CardSlide.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/19.
//

import SwiftUI

// CardSlide -> 카드 슬라이드 뷰 전체
// Card -> 카드에 들어갈 정보를 담는 구조체 타입
// UIStateModel -> 현재 카드id와 scroll 값을 통해 UI를 Published하는 EnvironmentOb
// Carousel -> 카드 Item들이 담길 Horizon 스크롤 가능한 뷰
// Item -> 카드의 정보가 입력되는 UI

struct CardSlide: View {
    @EnvironmentObject var UIState: UIStateModel

    var body: some View {
        // 각 카드 사이의 너비
        let spacing: CGFloat = 20
        // 숨겨진 카드의 보여질 width
        let widthOfHiddenCards: CGFloat = 40 /// UIScreen.main.bounds.width - 10
        // 카드의 Height
        let cardHeight: CGFloat = 359

        // 카드에 담길 모델들 데이터
        let items = [
            Card(id: 0, name: "Hey"),
            Card(id: 1, name: "Ho"),
            Card(id: 2, name: "Lets"),
            Card(id: 3, name: "Go")
        ]

        return Carousel(
            numberOfItems: CGFloat(items.count),
            spacing: spacing,
            widthOfHiddenCards: widthOfHiddenCards
        ) {
            // items를 돌며 생성
            ForEach(items, id: \.self.id) { item in
                Item(
                    // 카드 UI의 id
                    id: Int(item.id),
                    // 카드 사이의 너비
                    spacing: spacing,
                    // 가려진 카드의 너비
                    widthOfHiddenCards: widthOfHiddenCards,
                    // 카드의 높이
                    cardHeight: cardHeight
                ) {
                    Text("\(item.name)")
                }
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(8)
                .shadow(color: Color.gray, radius: 4, x: 0, y: 4)
                .transition(AnyTransition.slide)
                .animation(.spring())
            }
        }
    }
}

// 카드 내에 정보를 담는 모델
struct Card: Decodable, Hashable, Identifiable {
    var id: Int
    var name: String = ""
}

public class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
}

// 카드들이 담기는 Horizon 스크롤 뷰(?)같은 역할
struct Carousel<Items: View>: View {
    let items: Items
    let numberOfItems: CGFloat // = 8
    let spacing: CGFloat // = 16
    let widthOfHiddenCards: CGFloat // = 32
    let totalSpacing: CGFloat
    let cardWidth: CGFloat

    @GestureState var isDetectingLongPress = false

    @EnvironmentObject var UIState: UIStateModel

    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        @ViewBuilder _ items: () -> Items
    ) {
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2) // 279
    }

    var body: some View {
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing // 카드갯수 * 카드 너비 + (카드 갯수-1) * 카드 사이 너비
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2 // (총 너비 - 폰 너비) / 2
        // 현재 보이는 카드가 화면 좌측 가장자리에서 떨어져있는 거리
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing

        let activeOffset = xOffsetToShift + leftPadding - (totalMovement * CGFloat(UIState.activeCard))
        let nextOffset = xOffsetToShift + leftPadding - (totalMovement * CGFloat(UIState.activeCard) + 1)

        var calcOffset = Float(activeOffset)

        if calcOffset != Float(nextOffset) {
            calcOffset = Float(activeOffset) + UIState.screenDrag
        }

        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, _, _ in
            self.UIState.screenDrag = Float(currentState.translation.width)

        }.onEnded { value in
            self.UIState.screenDrag = 0

            if value.translation.width < -50 {
                if self.UIState.activeCard != Int(numberOfItems) - 1 {
                    self.UIState.activeCard += 1
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                }
            }

            if value.translation.width > 50 {
                if self.UIState.activeCard != 0 {
                    self.UIState.activeCard -= 1
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                }
            }
        })
    }
}

struct Canvas<Content: View>: View {
    let content: Content
    @EnvironmentObject var UIState: UIStateModel

    @inlinable init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

// 각 카드 정보가 담기는 UI 뷰
struct Item<Content: View>: View {
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

struct CardSlide_Previews: PreviewProvider {
    static var previews: some View {
        CardSlide()
            .environmentObject(UIStateModel())
    }
}

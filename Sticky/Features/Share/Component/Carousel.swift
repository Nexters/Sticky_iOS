//
//  Carousel.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/20.
//

import SwiftUI

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
        totalSpacing = (numberOfItems - 1) * spacing
        cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2) // 279
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

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        let items = [
            Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
            Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
            Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
        ]
        return Carousel(
            numberOfItems: CGFloat(items.count),
            spacing: 20,
            widthOfHiddenCards: 40
        ) {
            return ForEach(items, id: \.self.id) { item in
                CardItem(
                    // 카드 UI의 id
                    id: Int(item.id),
                    // 카드 사이의 너비
                    spacing: 20,
                    // 가려진 카드의 너비
                    widthOfHiddenCards: 40,
                    // 카드의 높이
                    cardHeight: 360, bgColor: Color.Sticky.blue_bg
                ) {
                    VStack {
                        HStack {
                            Text("LV.\(item.level)")
                                .fontWeight(.medium)
                            Text(item.nickname)
                        }
                        .padding(.bottom, 16)
                        .font(.system(size: 16))
                        .frame(width: 200, alignment: .leading)

                        VStack(alignment: .leading) {
                            Text("집에서")
                            Text("10일\n23시간 34분")
                                .fontWeight(.bold)
                            Text("동안")
                            Text("안나갔다.")
                        }
                        .frame(width: 200, height: 200, alignment: .leading)
                        .font(.system(size: 32))
                        .foregroundColor(.black)

                        Image("logo")
                            .frame(width: 60, height: 27)
                            .padding(.top, 25)
                    }
                }
                .foregroundColor(Color.blue)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.gray, radius: 4, x: 0, y: 4)
                .transition(AnyTransition.slide)
                .animation(.spring())
            }
        }
        .environmentObject(UIStateModel())
    }
}

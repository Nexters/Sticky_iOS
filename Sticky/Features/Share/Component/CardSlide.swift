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
    @Binding var items: [Card]

    var body: some View {
        // 각 카드 사이의 너비
        let spacing: CGFloat = 20
        // 숨겨진 카드의 보여질 width
        let widthOfHiddenCards: CGFloat = 40 /// UIScreen.main.bounds.width - 10
        // 카드의 Height
        let cardHeight: CGFloat = 359

        return Carousel(
            numberOfItems: CGFloat(items.count),
            spacing: spacing,
            widthOfHiddenCards: widthOfHiddenCards
        ) {
            // items를 돌며 생성
            ForEach(items, id: \.self.id) { item in
                CardItem(
                    // 카드 UI의 id
                    id: Int(item.id),
                    // 카드 사이의 너비
                    spacing: spacing,
                    // 가려진 카드의 너비
                    widthOfHiddenCards: widthOfHiddenCards,
                    // 카드의 높이
                    cardHeight: cardHeight
                ) {
                    VStack {
                        HStack {
                            Text("LV.\(item.level)")
                                .fontWeight(.medium)
                            Text(item.nickname)
                        }
                        .foregroundColor(Color.blue)
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
                .foregroundColor(Color.black)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.gray, radius: 4, x: 0, y: 4)
                .transition(AnyTransition.slide)
                .animation(.spring())
            }
        }
    }
}

public class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
}

struct CardSlide_Previews: PreviewProvider {
    static var previews: some View {
        CardSlide(items: .constant(items))
            .environmentObject(UIStateModel())
    }
}

// TestItems
let items = [
    Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
    Card(id: 1, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
    Card(id: 2, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
]

//
//  CardSlide.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/19.
//

import SwiftUI

// MARK: - CardSlide

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
        let spacing: CGFloat = 16
        // 숨겨진 카드의 보여질 width
        let widthOfHiddenCards: CGFloat = 40 /// UIScreen.main.bounds.width - 10
        // 카드의 Height
        let cardHeight: CGFloat = 368 // UIScreen.main.bounds.height * 0.5

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
                    ZStack {
                        VStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 56, height: 16)
                                .padding(.top, 24)
                            HStack(spacing: 24) {
                                VStack {
                                    Text("30")
                                        .font(.custom("Modak", size: 80))
                                        .frame(height: 64)
                                        .padding(.bottom, 1)
                                    Text("시간")
                                        .font(.system(size: 17, weight: .heavy, design: .default))
                                        .frame(width: 96)
                                }
                                // 얘 높이가 Text랑 달라서 그룹지어서 처리해야함
                                VStack {
                                    StrokeText(
                                        text: "34",
                                        size: 80,
                                        fontColor: UIColor.white
                                    )
                                    .padding(.bottom, 0)
                                    .frame(width: 80, height: 64)
                                    Text("분")
                                        .font(.system(size: 17, weight: .heavy, design: .default))
                                        .frame(width: 96)
                                }
                            }
                            .frame(width: 216)
                            .padding(.top, 24)
                            Text("body text")
                                .padding(.top, 24)
                            Spacer()
                        }
                        Image("blue_sticky")
                            .aspectRatio(contentMode: .fit)
                            .offset(y: 190)
                    }
                }
                .foregroundColor(Color.white)
                .background(Color.Sticky.blue)
                .cornerRadius(40)
                .shadow(color: Color.gray, radius: 4, x: 0, y: 4)
                .transition(AnyTransition.slide)
                .animation(.spring())
            }
        }
    }
}

// MARK: - UIStateModel

public class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
}

// MARK: - CardSlide_Previews

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


//
//  CardItem.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/20.
//

import SwiftUI

// MARK: - CardItem

// 각 카드 정보가 담기는 UI 뷰
struct CardItem<Content: View>: View {
    // MARK: Lifecycle

    @inlinable public init(
        id: Int,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        cardHeight: CGFloat,
        bgColor: LinearGradient,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2)
        self.cardHeight = cardHeight
        self.id = id
        self.widthOfHiddenCards = widthOfHiddenCards
        self.spacing = spacing
        self.bgColor = bgColor
    }

    // MARK: Internal

    @EnvironmentObject var UIState: UIStateModel
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    let widthOfHiddenCards: CGFloat
    let spacing: CGFloat
    var id: Int
    let bgColor: LinearGradient

    var content: Content

    var body: some View {
        // Active 카드인지 확인
        // Active 카드가 아닌 카드들은 여기서 UI/Design 수정

        GeometryReader { gr in
//            VStack {
            content
                .onReceive(NotificationCenter.default.publisher(for: .captureScreen), perform: { noti in
                    guard let id = noti.userInfo?["index"] as? Int else { return }
                    if self.id == id {
                        print("capture\(UIState.activeCard)")
                        saveInPhoto(img: captureCardImage(origin: gr.frame(in: .global).origin, size: gr.size))
                    }
                })
                .onReceive(NotificationCenter.default.publisher(for: .shareLocal), perform: { noti in
                    print("CardItem - Notification(shareLocal)")
                    guard let id = noti.userInfo?["index"] as? Int else { return }
                    if self.id == id {
                        print("shareLocal")
                        shareLocal(image: captureCardImage(origin: gr.frame(in: .global).origin, size: gr.size))
                    }
                })
                .onReceive(NotificationCenter.default.publisher(for: .shareInstagram), perform: { noti in
                    print("CardItem - Notification(shareInstagram)")
                    guard let id = noti.userInfo?["index"] as? Int else { return }
                    guard let bgColor = noti.userInfo?["bgColor"] as? LinearGradient else { return }
                    if self.id == id {
                        print("shareInstagram")
                        shareInstagram(
                            bgImage: captureBGImage(bgColor: bgColor),
                            cardImage: captureCardImage(origin: gr.frame(in: .global).origin, size: gr.size)
                        )
                    }
                })
//            }
        }
        .frame(
            width: UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2),
            height: cardHeight,
            alignment: .center
        )
    }
}

// MARK: - CardItem_Previews

struct CardItem_Previews: PreviewProvider {
    static var previews: some View {
        let items = [
            Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
            Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
            Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
        ]
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                CardItem(
                    // 카드 UI의 id
                    id: Int(items[0].id),
                    // 카드 사이의 너비
                    spacing: 20,
                    // 가려진 카드의 너비
                    widthOfHiddenCards: 40,
                    // 카드의 높이
                    cardHeight: 360,
                    bgColor: Color.Sticky.blue_bg
                ) {
                    Text("\(items[0].nickname)")
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
}

//
//  CardSlideView.swift
//  Sticky
//
//  Created by deo on 2021/02/01.
//

import SwiftUI

// MARK: - CardSlideView

struct CardSlideView: View {
    // MARK: Internal

    @EnvironmentObject var UIState: UIStateModel
    @ObservedObject var badgeViewModel: BadgeViewModel
    @ObservedObject var shareViewModel: ShareViewModel

    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Button(action: { UIState.activeCard = 0 }) {
                    Text("현재 기록")
                        .kerning(-0.3)
                        .bold()
                        .font(.system(size: 17))
                        .foregroundColor(Color.black.opacity(UIState.activeCard == 0 ? 1 : 0.5))
//                        .opacity(UIState.activeCard == 0 ? 0 : 0.5)
                }

                Button(action: { UIState.activeCard = 1 }) {
                    Text("받은 배지")
                        .kerning(-0.3)
                        .bold()
                        .font(.system(size: 17))
                        .foregroundColor(Color.black.opacity(UIState.activeCard == 1 ? 1 : 0.5))
//                        .opacity(UIState.activeCard == 1 ? 0 : 0.5)
                }
            }
            .padding(.bottom, 16)
            .foregroundColor(Color.white)
            CardSlide(
                badgeViewModel: badgeViewModel,
                shareViewModel: shareViewModel,
                items: $items
            )
            HStack {
                Text("나의 ")+Text(getBottomString()).bold()+Text(" 공유합니다")
            }
            .font(.system(size: 14))
            .foregroundColor(.black)
            .padding(.top, 16)
        }
    }

    // MARK: Private

    @State private var items = [
        Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
        Card(id: 1, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
    ]

    private func getBottomString() -> String {
        switch UIState.activeCard {
        case 0:
            return "현재 기록을"
        case 1:
            return "최근 뱃지를"
        default:
            return "알수없음"
        }
    }
}

// MARK: - CardSlideView_Previews

struct CardSlideView_Previews: PreviewProvider {
    static var previews: some View {
        CardSlideView(
            badgeViewModel: BadgeViewModel(),
            shareViewModel: ShareViewModel()
        )
        .environmentObject(UIStateModel())
    }
}

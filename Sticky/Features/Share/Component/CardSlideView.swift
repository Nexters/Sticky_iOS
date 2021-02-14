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

    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Button("현재 기록", action: { UIState.activeCard = 0 })
                    .font(.system(size: 17, weight: .heavy, design: .default))
                    .foregroundColor(UIState.activeCard == 0 ? .black : .gray)

                Button("받은 배지", action: { UIState.activeCard = 1 })
                    .font(.system(size: 17, weight: .heavy, design: .default))
                    .foregroundColor(UIState.activeCard == 1 ? .black : .gray)
            }
            .padding(.bottom, 16)
            .foregroundColor(Color.white)
            CardSlide(items: $items)
            HStack {
                Text("나의")
                Text(getBottomString()).bold()
                Text("공유합니다")
            }
            .font(.title3)
            .foregroundColor(.black)
            .padding(.top, 20)
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
        CardSlideView()
            .environmentObject(UIStateModel())
    }
}

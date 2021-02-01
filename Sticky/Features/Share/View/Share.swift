//
//  Share.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/19.
//

import SwiftUI

// MARK: - Share

struct Share: View {
    // MARK: Lifecycle

    init() {
        let newNavAppearance = UINavigationBarAppearance()
        newNavAppearance.configureWithTransparentBackground()
        newNavAppearance.backgroundColor = .clear
        UINavigationBar.appearance()
            .standardAppearance = newNavAppearance
    }

    // MARK: Internal

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var UIState: UIStateModel

    var body: some View {
        ZStack {
            // 배경 Color
            Color.Sticky.blue_end
                .opacity(0.2)
                .edgesIgnoringSafeArea(.vertical)

            VStack {
                Spacer()
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
                // 카드 슬라이드 뷰
                CardSlide(items: $items)
                Spacer()
                HStack {
                    Text("나의")
                    Text(getBottomString()).bold()
                    Text("공유합니다")
                }
                .font(.title3)
                .foregroundColor(.black)
                .padding(.top, 20)

                ShareButtons()
                    .padding(.top, 32)
                Spacer()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: backButton,
            trailing: downloadButton
        )
    }

    // MARK: Private

    // 카드에 담길 모델들 데이터
    @State private var items = [
        Card(id: 0, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
        Card(id: 1, level: 30, nickname: "이불밖은 위험해", totalTime: "10일 23시간 34분"),
    ]

    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image("back")
                .aspectRatio(contentMode: .fit)
        }
    }

    private var downloadButton: some View {
        Button(action: {
            saveInPhoto(img: takeCapture())
        }) {
            Image("download")
                .aspectRatio(contentMode: .fit)
        }
    }

    private func getBottomString() -> String {
        switch UIState.activeCard {
        case 0:
            return "현재 기록을"
        case 1:
            return "누적 기록을"
        case 2:
            return "최근 뱃지를"
        default:
            return "알수없음"
        }
    }
}

// MARK: - Share_Previews

struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share()
            .environmentObject(UIStateModel())
    }
}

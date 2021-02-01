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

    init(shareType: ShareType) {
        let newNavAppearance = UINavigationBarAppearance()
        newNavAppearance.configureWithTransparentBackground()
        newNavAppearance.backgroundColor = .clear
        UINavigationBar.appearance()
            .standardAppearance = newNavAppearance
        self.shareType = shareType
    }

    // MARK: Internal

    var shareType = ShareType.slide

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            // 배경 Color
            Color.Sticky.blue_end
                .opacity(0.2)
                .edgesIgnoringSafeArea(.vertical)

            VStack {
                Spacer()

                setCardView(shareType: shareType)

                Spacer()
                ShareButtons()
                    .padding(.bottom, 36)
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

    private func setCardView(shareType: ShareType) -> AnyView {
        var view: AnyView
        switch shareType {
        case .slide:
            view = AnyView(CardSlideView())

        case .level:
            view = AnyView(LevelView(
                level: 3,
                grade: "Yellow Sticky",
                total_time: TimeData(day: 4, hour: 20)
            ))
        default:
            view = AnyView(Text("지원하지 않는 타입"))
        }

        return view
    }
}

// MARK: - Share_Previews

struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share(shareType: ShareType.slide)
            .environmentObject(UIStateModel())
    }
}


//
//  Share.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/19.
//

import SwiftUI

// MARK: - Share

struct Share: View {
    // MARK: Internal

//    init(shareType: ShareType, badgeViewModel: BadgeViewModel, ) {
//        self.shareType = shareType
//        self.badgeViewModel = badgeViewModel
//    }

    @State var bgColor: LinearGradient = Color.Sticky.blue_bg
    var shareType: ShareType

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var UIState: UIStateModel
    @EnvironmentObject var user: User
    @EnvironmentObject var challengeState: ChallengeState

    @ObservedObject var shareViewModel: ShareViewModel
    @ObservedObject var badgeViewModel: BadgeViewModel

    var body: some View {
        ZStack {
            // 배경 Color
            setBackgroundColor(type: shareViewModel.badge.badgeType)
                .edgesIgnoringSafeArea(.vertical)

            VStack {
                Spacer()

                setCardView(shareType: shareType)

                Spacer()

                ShareButtons(
                    textColor: shareType == .card ? .white : .black,
                    bgColor: $bgColor,
                    shareId: 0
                )
                .padding(.bottom, 36)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: backButton,
            trailing: downloadButton
        )
        .onDisappear {
            if challengeState.type == .notRunning {
                shareViewModel.seconds = 0
            }
        }
    }

    // MARK: Private

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
            print("download")
            NotificationCenter.default.post(name: .captureScreen, object: nil, userInfo: ["index": UIState.activeCard, "bgColor": bgColor])
        }) {
            Image("download")
                .aspectRatio(contentMode: .fit)
        }
    }

    private func setBackgroundColor(type: BadgeType) -> AnyView {
        switch shareType {
        case .slide:
            return AnyView(setColor().ignoresSafeArea())

        default:
            switch type {
            case .level,
                 .unknown:
                bgColor = Color.Sticky.blue_bg
                return
                    AnyView(
                        ZStack {
                            Color.Sticky.blue_bg.ignoresSafeArea()
                            Color.black.opacity(0.3)
                        }
                    )
            case .monthly:
                bgColor = Color.Sticky.blue_bg
                return AnyView(Color.Sticky.blue_bg.ignoresSafeArea())
            case .continuous:
                bgColor = Color.Sticky.red_bg
                return AnyView(Color.Sticky.red_bg.ignoresSafeArea())
            case .special:
                bgColor = Color.Sticky.blue_bg
                return AnyView(Color.Sticky.blue_bg.ignoresSafeArea())
            }
        }
    }

    private func setColor() -> Color {
        var color: Color
        switch user.level {
        case 0...3:
            color = Color.Background.blue
        case 4...6:
            color = Color.Background.yellow
        case 7...9:
            color = Color.Background.green
        case 10:
            color = Color.Background.red
        default:
            print("Main - Should Implement Another Background Color Case in level")
            color = Color.Background.blue
        }

        return color
    }

    private func setCardView(shareType: ShareType) -> AnyView {
        var view: AnyView
        print("setCardView")
        switch shareType {
        case .slide:
            view = AnyView(CardSlideView(
                badgeViewModel: badgeViewModel,
                shareViewModel: shareViewModel
            ))

        case .card:
            let badge = shareViewModel.badge
            let image = badge.image
            let title = badge.name
            var value = ""
            switch badge.badgeType {
            case .continuous,
                 .monthly,
                 .special,
                 .unknown:
                value = badge.name
            case .level:
                value = "\(shareViewModel.seconds.ToDaysHoursMinutes())"
            }
            let description = badge.badgeType.toString(value: value)
            view = AnyView(VStack {
                ShareCardView(
                    image: image,
                    title: title,
                    description: description
                )
                HStack {
                    Text("나의 ")
                        .kerning(-0.3) + Text(shareViewModel.badge.badgeType.alias).bold()
                        .kerning(-0.3) + Text("을 공유합니다")
                        .kerning(-0.3)
                }
                .font(.system(size: 14))
                .foregroundColor(.white)
                .padding(.top, 17)
            })
        }

        return view
    }
}

// MARK: - Share_Previews

struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share(
            shareType: ShareType.card,
            shareViewModel: ShareViewModel(),
            badgeViewModel: BadgeViewModel()
        )
        .environmentObject(ShareViewModel())
        .environmentObject(UIStateModel())
    }
}

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

    var shareType: ShareType

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var shareViewModel: ShareViewModel

    var body: some View {
        ZStack {
            // 배경 Color
            setBackgroundColor(type: shareViewModel.badge.badgeType)
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

    private func setBackgroundColor(type: BadgeType) -> AnyView {
        switch type {
        case .level:
            return
                AnyView(
                    ZStack {
                        Color.Sticky.blue_bg.ignoresSafeArea()
                        Color.black.opacity(0.3)
                    }
                )
        case .monthly:
            return AnyView(Color.Sticky.blue_bg.ignoresSafeArea())
        case .continuous:
            return AnyView(Color.Sticky.red_bg.ignoresSafeArea())
        case .special:
            return AnyView(Color.Sticky.blue_bg.ignoresSafeArea())
        }
    }

    private func setCardView(shareType: ShareType) -> AnyView {
        var view: AnyView
        switch shareType {
        case .slide:
            view = AnyView(CardSlideView())

        case .card:
            let badge = shareViewModel.badge
            let image = badge.image
            let title = badge.name
            var value = ""
            switch badge.badgeType {
            case BadgeType.special:
                value = ""
            case BadgeType.monthly:
                value = "\(badge.badgeValue)시간"
            case BadgeType.continuous:
                let _value = badge.badgeValue
                let unit = _value == "0.5" ? "시간" : "일"
                value = "\(_value)\(unit)"
            case BadgeType.level:
                value = "\(shareViewModel.seconds.ToDaysHoursMinutes())"
            }
            let description = badge.badgeType.format(value: value)
            view = AnyView(ShareCardView(
                image: image,
                title: title,
                description: description
            ))
        }

        return view
    }
}

// MARK: - Share_Previews

struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share(shareType: ShareType.card)
            .environmentObject(ShareViewModel())
            .environmentObject(UIStateModel())
    }
}

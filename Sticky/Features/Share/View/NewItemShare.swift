//
//  NewItemShare.swift
//  Sticky
//
//  Created by deo on 2021/02/14.
//

import SwiftUI

// MARK: - NewItemShare

struct NewItemShare: View {
    // MARK: Internal

    @EnvironmentObject var user: User
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var badgeQueue: [Badge]

    @State var image: String = ""
    @State var description: String = ""
    @State var value: String = ""
    @State var badge = Badge(badgeType: .level, badgeValue: "1")
    var seconds: Int

    var body: some View {
        return
            ZStack {
                LottieView(name: "tada")
                    .ignoresSafeArea()

                VStack {
                    ShareCongratulation(
                        image: image,
                        badge: badge,
                        description: description
                    )

                    HStack {
                        Text("새로 달성한 \(badge.badgeType.alias)").bold() + Text("을 자랑해보세요!")
                    }.padding(.top, 66)

                    ShareButtons(textColor: Color.white, bgColor: .constant(Color.Sticky.blue_bg), shareId: 1)
                        .foregroundColor(Color.Palette.negative)
                        .padding(.bottom, 36)

                }.foregroundColor(.white)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(
                        leading: backButton,
                        trailing: downloadButton
                    )
            }.onAppear {
                changeBadge()
            }
    }

    // MARK: Private

    private var backButton: some View {
        Button(action: {
            if !self.badgeQueue.isEmpty {
                self.badgeQueue.remove(at: 0)
                if self.badgeQueue.isEmpty {
                    self.presentationMode.wrappedValue.dismiss()
                }
                changeBadge()
            }

        }) {
            Image("ic_close")
                .aspectRatio(contentMode: .fit)
        }
    }

    private var downloadButton: some View {
        Button(action: {
            NotificationCenter.default.post(name: .captureCongratulation, object: nil)
        }) {
            Image("ic_download")
                .aspectRatio(contentMode: .fit)
        }
    }

    private func changeBadge() {
        if let firstBadge = badgeQueue.first {
            badge = firstBadge
            image = badge.image
            value = ""
            switch badge.badgeType {
            case .special:
                break
            case .continuous,
                 .monthly:
                value = badge.name
            case .level:
                value = "\(seconds.ToDaysHoursMinutes())"
            }
            description = badge.badgeType.toString(value: value)
        }
    }
}

// MARK: - ShareCongratulation

struct ShareCongratulation: View {
    let image: String
    let badge: Badge
    let description: String

    var body: some View {
        GeometryReader { gr in
            VStack {
                Text("CONGRATULATION!")
                    .kerning(-0.3)
                    .font(.custom("Modak", size: 28))

                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                Text(badge.name)
                    .kerning(-0.3)
                    .font(.custom("Modak", size: 28))
                Text(description)
                    .kerning(-0.3)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
            }
            .foregroundColor(.white)
            .onReceive(NotificationCenter.default.publisher(for: .captureCongratulation), perform: { _ in

                saveInPhoto(img: captureWithBG(origin: gr.frame(in: .global).origin, size: gr.size, bgColor: nil))

            }).onReceive(NotificationCenter.default.publisher(for: .shareInstagramCongratulation), perform: { _ in
                shareInstagram(
                    bgImage: captureBGImage(bgColor: nil),
                    cardImage: captureCardImageCongratulation(origin: gr.frame(in: .global).origin, size: gr.size)
                )

            }).onReceive(NotificationCenter.default.publisher(for: .shareLocalCongratulation), perform: { _ in

                shareLocal(image: captureWithBG(origin: gr.frame(in: .global).origin, size: gr.size, bgColor: nil))

            })
            .frame(width: gr.frame(in: .global).width, height: gr.frame(in: .global).height, alignment: .bottom)
        }
    }
}

// MARK: - NewItemShare_Previews

struct NewItemShare_Previews: PreviewProvider {
    static var previews: some View {
        NewItemShare(badgeQueue: .constant([]), seconds: 0)
            .environmentObject(User())
    }
}

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

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var user: User
    @Binding var badgeQueue: [Badge]

    var body: some View {
        let badge = self.badgeQueue.first ??
            Badge(badgeType: .level, badgeValue: "1")
        let image = badge.image
        var value = ""
        switch badge.badgeType {
        case .special: break
        case .continuous,
             .monthly:
            value = badge.name
        case .level:
            let seconds = user.accumulateSeconds + user.thisMonthAccumulateSeconds
            value = "\(seconds.ToDaysHoursMinutes())"
        }
        let description = badge.badgeType.toString(value: value)
        return ZStack {
            LottieView(name: "tada")
                .ignoresSafeArea()

            VStack {
                Spacer()
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

                HStack {
                    Text("새로 달성한 레벨").bold() + Text("을 자랑해보세요!")
                }.padding(.top, 66)
                ShareButtons(textColor: Color.white)
                    .foregroundColor(Color.Palette.negative)
                    .padding(.bottom, 36)
            }.foregroundColor(.white)
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
            if !self.badgeQueue.isEmpty {
                self.badgeQueue.remove(at: 0)
            }
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image("ic_close")
                .aspectRatio(contentMode: .fit)
        }
    }

    private var downloadButton: some View {
        Button(action: {
            print("download")
        }) {
            Image("ic_download")
                .aspectRatio(contentMode: .fit)
        }
    }
}

// MARK: - NewItemShare_Previews

struct NewItemShare_Previews: PreviewProvider {
    static var previews: some View {
        NewItemShare(badgeQueue: .constant([]))
            .environmentObject(BadgeViewModel())
    }
}

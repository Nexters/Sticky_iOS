//
//  MyPage.swift
//  Sticky
//
//  Created by deo on 2021/01/21.
//

import SwiftUI

// MARK: - MyPage

struct MyPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var level: Int = 0
    var camulate: Int = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Summary()
                    .padding(.bottom, 15)
                Divider()
                    .padding(.bottom, 15)
                Text("나의 달성 기록")
                    .font(.system(size: 18))
                    .bold()

                BadgePanel(leading: "누적 달성", trailing: "이번 달", badges: badgeMocks)
                BadgePanel(leading: "연속 달성", badges: badgeMocks)
                BadgePanel(leading: "스페셜 달성", badges: badgeMocks)
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("마이페이지", displayMode: .inline)
        .navigationBarItems(
            leading: backButton,
            trailing:
            NavigationLink(destination: More()) {
                Image("more")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            })
    }

    var backButton: some View {
        Button(action: focusRelease) {
            HStack {
                Image("close")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
        }
    }

    func focusRelease() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - MyPage_Previews

struct MyPage_Previews: PreviewProvider {
    static var previews: some View {
        MyPage(level: 3)
    }
}

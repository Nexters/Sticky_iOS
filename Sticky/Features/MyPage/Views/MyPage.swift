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
    @State private var more = false
    @State private var shareType = ShareType.level
    @State private var navSelection: String?

    var total_seconds: Int = 200000

    var body: some View {
        ScrollView {
            NavigationLink(destination: More(more: $more), isActive: $more) {
                EmptyView()
            }
            NavigationLink(destination: Share(), tag: "share", selection: $navSelection) { EmptyView() }

            VStack(alignment: .leading, spacing: 20) {
                Summary(seconds: total_seconds)
                    .padding(.bottom, 15)
                Divider()
                    .padding(.bottom, 15)
                BadgePanel(
                    title: "스페셜 달성",
                    subtitle: "특별한 기록을 달성하면 받을 수 있어요.",
                    badges: badgeMocks(count: 6),
                    selection: $navSelection
                )
                BadgePanel(
                    title: "월간 달성",
                    subtitle: "한달 내에 쌓은 시간을 기준으로 합니다.",
                    trailing: "이번 달",
                    badges: badgeMocks(count: 9),
                    selection: $navSelection
                )
                BadgePanel(
                    title: "연속 달성",
                    subtitle: "멈추지 않고 이어서 기록된 시간을 기준으로 합니다.",
                    badges: badgeMocks(count: 9),
                    selection: $navSelection
                )

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("마이페이지", displayMode: .inline)
        .navigationBarItems(
            leading: backButton,
            trailing: moreButton
        )
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

    var moreButton: some View {
        Button(action: {
            self.more = true
        }) {
            HStack {
                Image("more")
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
        MyPage(total_seconds: 100)
    }
}

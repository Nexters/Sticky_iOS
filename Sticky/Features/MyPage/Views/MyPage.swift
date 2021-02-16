//
//  MyPage.swift
//  Sticky
//
//  Created by deo on 2021/01/21.
//

import SwiftUI

// MARK: - MyPage

struct MyPage: View {
    // MARK: Internal

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var badgeViewModel: BadgeViewModel
    @EnvironmentObject var user: User
    @EnvironmentObject var challengeState: ChallengeState
    @State var showingActionSheet = false

    var monthlyButton: some View {
        AnyView(
            HStack {
                Text("\(badgeViewModel.showCountBadge ? "전체 기간" : "이번 달")")
                Button(action: {
                    self.showingActionSheet = true
                }, label: {
                    Image("slice")
                        .aspectRatio(contentMode: .fit)
                })
                    .actionSheet(isPresented: $showingActionSheet, content: {
                        ActionSheet(
                            title: Text("월간 달성")
                                .bold()
                                .foregroundColor(.black),
                            message: nil,
                            buttons: [
                                .default(Text("전체 기록 보기"), action: {
                                    badgeViewModel.showCountBadge = true
                                }),
                                .default(Text("이번달 기록 보기"), action: {
                                    badgeViewModel.showCountBadge = false
                                }),
                                .cancel(Text("취소"))
                            ]
                        )
                    })
            }
        )
    }

    var body: some View {
        ScrollView {
            NavigationLink(destination: More(more: $more), isActive: $more) {
                EmptyView()
            }
            NavigationLink(
                destination: Share(shareType: ShareType.card),
                tag: ShareType.card,
                selection: $navSelection
            ) { EmptyView() }

            VStack(alignment: .leading, spacing: 20) {
                Summary(
                    seconds: user.accumulateSeconds + challengeState.timeData.toSeconds(),
                    selection: $navSelection
                )
                .padding(.bottom, 15)
                Divider()
                    .padding(.bottom, 15)
                BadgePanel(
                    title: "스페셜 달성",
                    subtitle: "특별한 기록을 달성하면 받을 수 있어요.",
                    badges: [],
                    selection: $navSelection,
                    showCountBadge: $badgeViewModel.showCountBadge
                )
                BadgePanel(
                    title: "월간 달성",
                    subtitle: "한달 내에 쌓은 시간을 기준으로 합니다.",
                    trailing: monthlyButton as? AnyView,
                    badges: makeBadges(
                        badgeType: BadgeType.monthly,
                        dict: badgeViewModel.showCountBadge ?
                            filterByThisMonth(badges: badgeViewModel.monthly.items) :
                            badgeViewModel.monthly.items
                    ),
                    selection: $navSelection,
                    showCountBadge: $badgeViewModel.showCountBadge
                )
                BadgePanel(
                    title: "연속 달성",
                    subtitle: "멈추지 않고 이어서 기록된 시간을 기준으로 합니다.",
                    badges: makeBadges(
                        badgeType: BadgeType.continuous,
                        dict: badgeViewModel.continuous.items
                    ),
                    selection: $navSelection,
                    showCountBadge: .constant(false)
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
        .onAppear {
            print("Special: \(badgeViewModel.specials)")
            print("Monthly: \(badgeViewModel.monthly)")
            print("Continuous: \(badgeViewModel.continuous)")
            print("챌린지 시간 누적: \(user.accumulateSeconds)")
        }
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
        presentationMode.wrappedValue.dismiss()
    }

    // MARK: Private

    @State private var more = false
    @State private var navSelection: ShareType?
}

// MARK: - MyPage_Previews

struct MyPage_Previews: PreviewProvider {
    static var previews: some View {
        MyPage(badgeViewModel: BadgeViewModel())
            .environmentObject(User())
            .environmentObject(ChallengeState())
    }
}

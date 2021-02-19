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

    @EnvironmentObject var user: User
    @EnvironmentObject var challengeState: ChallengeState
    @StateObject var shareViewModel: ShareViewModel
    @StateObject var badgeViewModel: BadgeViewModel

    @State var showingActionSheet = false

    var monthlyButton: some View {
        AnyView(
            HStack {
                Button(action: {
                    self.showingActionSheet = true
                }, label: {
                    Text("\(badgeViewModel.showCountBadge ? "전체 기간" : "이번 달")")
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                    Image("slice")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
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
                destination: Share(
                    shareType: ShareType.card,
                    shareViewModel: shareViewModel,
                    badgeViewModel: badgeViewModel
                ),
                tag: ShareType.card,
                selection: $navSelection
            ) { EmptyView() }

            VStack(alignment: .leading, spacing: 20) {
                Summary(
                    seconds: user.accumulateSeconds,
                    selection: $navSelection,
                    shareViewModel: shareViewModel
                )
                .padding(.bottom, 15)
                Divider()
                    .padding(.bottom, 15)
                BadgePanel(
                    title: "스페셜 달성",
                    subtitle: "특별한 기록을 달성하면 받을 수 있어요.",
                    badges: badgeViewModel.specials,
                    selection: $navSelection,
                    showCountBadge: .constant(false),
                    shareViewModel: shareViewModel
                )
                BadgePanel(
                    title: "월간 달성",
                    subtitle: "한달 내에 쌓은 시간을 기준으로 합니다.",
                    trailing: monthlyButton as? AnyView,
                    badges: badgeViewModel.monthly,
                    selection: $navSelection,
                    showCountBadge: $badgeViewModel.showCountBadge,
                    shareViewModel: shareViewModel
                )
                BadgePanel(
                    title: "연속 달성",
                    subtitle: "멈추지 않고 이어서 기록된 시간을 기준으로 합니다.",
                    badges: badgeViewModel.continuous,
                    selection: $navSelection,
                    showCountBadge: .constant(false),
                    shareViewModel: shareViewModel
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
        .navigationBarColor(UIColor.white, textColor: UIColor.black)
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
        MyPage(shareViewModel: ShareViewModel(), badgeViewModel: BadgeViewModel())
            .environmentObject(User())
            .environmentObject(ChallengeState())
    }
}

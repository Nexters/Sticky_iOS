//
//  Banner.swift
//  Sticky
//
//  Created by deo on 2021/02/10.
//

import SwiftUI

// MARK: - Banner

struct Banner: View {
    // MARK: Internal

    @Binding var bannerDetailPresented: Bool
    @Binding var mypagePresented: Bool

    @EnvironmentObject var user: User
    @EnvironmentObject var challengeState: ChallengeState
    @StateObject var badgeViewModel: BadgeViewModel

    var body: some View {
        var nextMonthlyBadge = nextBadge(
            badgeType: BadgeType.monthly,
            badges: self.badgeViewModel.monthly.items
        )
        // 월간 배지 획득까지 남은 seconds; 뱃지 필요한 시간 - (챌린지 시간 + 이번 달 누적 시간)
        let remainMonthlyBadge = (Int(nextMonthlyBadge.badgeValue) ?? 0) * 3600
            - (challengeState.timeData.toSeconds() + user.thisMonthAccumulateSeconds)
        var nextContiousBadge = nextBadge(
            badgeType: BadgeType.continuous,
            badges: self.badgeViewModel.continuous.items
        )
        // 연속 배지 획득까지 남은 seconds; 뱃지 필요한 시간 - 챌린지 시간
        var remainContinuousBadge = nextContiousBadge.badgeValue == "0.5" ? 12 * 3600 : (Int(nextContiousBadge.badgeValue) ?? 0) * 3600 * 24
        remainContinuousBadge -= challengeState.timeData.toSeconds()

        if remainMonthlyBadge <= 0 {
            let key = nextMonthlyBadge.badgeValue
            nextMonthlyBadge.updated = Date()
            nextMonthlyBadge.count = 1
            badgeViewModel.monthly.items[key] = CountAndUpdated(count: 1, date: Date())
            badgeViewModel.badgeQueue.append(nextMonthlyBadge)
        } else {
            print("월간 배지 획득 남은 시간: \(remainMonthlyBadge)")
        }
        if remainContinuousBadge <= 0 {
            let key = nextContiousBadge.badgeValue
            nextContiousBadge.updated = Date()
            nextContiousBadge.count = 1
            badgeViewModel.continuous.items[key] = CountAndUpdated(count: 1, date: Date())
            badgeViewModel.badgeQueue.append(nextContiousBadge)
        } else {
            print("연속 배지 획득 남은 시간: \(remainContinuousBadge)")
        }

        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button(action: {
                    self.bannerDetailPresented = true
                    self.badgeViewModel.select = nextMonthlyBadge
                }) {
                    BannerItem(
                        image: nextMonthlyBadge.image,
                        title: nextMonthlyBadge.name,
                        subtitle: "\(remainTime(remainMonthlyBadge)) 남음"
                    )
                }
                Button(action: {
                    self.bannerDetailPresented = true
                    self.badgeViewModel.select = nextContiousBadge
                }) {
                    BannerItem(
                        image: nextContiousBadge.image,
                        title: nextContiousBadge.name,
                        subtitle: "\(remainTime(remainContinuousBadge)) 남음"
                    )
                }
                Button(action: { self.mypagePresented = true }) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 96, height: 60)
                        .foregroundColor(Color.TextIconColor.secondary)
                        .overlay(
                            HStack {
                                Text("더보기")
                                Image("arrow_right")
                            }
                        )
                }
            }
        }
        .foregroundColor(.black)
        .padding(.leading, 16)
    }

    // MARK: Private

    private func remainTime(_ seconds: Int) -> String {
        if seconds >= 86400 {
            return "약 \(seconds.ToDaysHoursMinutes(allowedUnits: [.day, .hour]))"
        } else {
            return seconds.ToDaysHoursMinutes()
        }
    }
}

// MARK: - Banner_Previews

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner(
            bannerDetailPresented: .constant(true),
            mypagePresented: .constant(true),
            badgeViewModel: BadgeViewModel()
        )
    }
}

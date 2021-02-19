//
//  TimerOn.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/25.
//

import SwiftUI

// MARK: - BottomTimerNotRunning

struct BottomTimerNotRunning: View {
    // MARK: Internal

    @EnvironmentObject var locationManager: LocationManager
    @StateObject var badgeViewModel: BadgeViewModel

    var body: some View {
        VStack {
//                NavigationLink(destination: MyPage()) {
//                    Text("MyPage")
//                }

//                Button(action: {
//                    popupState.isPresented = true
//                }, label: {
//                    Text("팝업")
//                })

            Button(action: {
                self.challengeState.seconds = 0
                self.challengeState.numberOfHeart = 3
                self.challengeState.type = .running
                locationManager.resetGeofence()
                if let badge = getWelcomeBadge(badges: badgeViewModel.specials) {
                    if !badge.active {
                        badge.count += 1
                        badge.updated = Date()
                        badgeViewModel.badgeQueue.append(badge)
                        badgeViewModel.specials = badgeViewModel.specials
                    }
                }
            }) {
                GradientRoundedButton(
                    content: "시작하기",
                    startColor: Color.black,
                    endColor: Color.black,
                    width: 328,
                    height: 60,
                    cornerRadius: 16.0,
                    fontColor: Color.white,
                    icon: "ic_play"
                ).padding(.bottom, 24)
            }
        }
    }

    // MARK: Private

    @EnvironmentObject private var challengeState: ChallengeState
}

// MARK: - TimerNotRunning_Previews

struct TimerNotRunning_Previews: PreviewProvider {
    static var previews: some View {
        BottomTimerNotRunning(badgeViewModel: BadgeViewModel())
    }
}

//
//  Main.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import CoreLocation
import SwiftUI
import UserNotifications

// MARK: - Main

struct Main: View {
    enum ChallengeType: Int, Codable {
        case notRunning
        case running
        case notAtHome
        case outing
    }

    @EnvironmentObject private var user: User
    @EnvironmentObject private var challengeState: ChallengeState
    @StateObject private var shareViewModel = ShareViewModel()
    @StateObject private var badgeViewModel = BadgeViewModel()

    @EnvironmentObject private var popupState: PopupStateModel
    @EnvironmentObject private var locationManager: LocationManager
    @EnvironmentObject private var rootManager: RootViewManager

    @State var sharePresented: Bool = false
    @State var bannerDetailPresented: Bool = false
    @State var mypagePresented: Bool = false
    @State var showNewBadge: Bool = false

    @State var color = Color.Palette.primary
    @State var timer: Timer? = nil
    @State static var isFirst: Bool = true
    @State var flag = true
    @State var countTime = 3

    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: Share(
                        shareType: ShareType.slide,
                        shareViewModel: shareViewModel,
                        badgeViewModel: badgeViewModel
                    ),
                    isActive: $sharePresented
                ) { EmptyView() }

                NavigationLink(
                    destination: MyPage(
                        shareViewModel: shareViewModel,
                        badgeViewModel: badgeViewModel
                    ),
                    isActive: $mypagePresented
                ) { EmptyView() }

                NavigationLink(
                    destination: NewItemShare(badgeQueue: $badgeViewModel.badgeQueue, seconds: user.accumulateSeconds),
                    isActive: $showNewBadge
                ) { EmptyView() }

                setColor()
                    .ignoresSafeArea()

                VStack {
                    Banner(
                        bannerDetailPresented: $bannerDetailPresented,
                        mypagePresented: $mypagePresented,
                        badgeViewModel: badgeViewModel
                    )
                    Spacer()
                    TimerView(seconds: $challengeState.seconds)
                    Spacer()
                    setBottomView()
                        .padding(.bottom, 24)
                }

                Outing(timer: $timer, flag: $flag, countTime: $countTime)
                    .isHidden(!(challengeState.type == .outing))

                PopupMessage(
                    isPresented: $popupState.isPresented,
                    numberOfHeart: $challengeState.numberOfHeart,
                    message: self.popupState.popupStyle.getMessage(),
                    confirmHandler: confirmInPopup,
                    rateOfWidth: 0.8
                )
                .isHidden(!popupState.isPresented)
                .ignoresSafeArea(.all)

                BannerItemDetail(
                    isPresented: $bannerDetailPresented,
                    badge: $badgeViewModel.select
                )
                .isHidden(!bannerDetailPresented)
                .ignoresSafeArea(.all)
            }
            .navigationBarHidden(!flag)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                leading: mypageButton,
                trailing: stopButton.isHidden(!(challengeState.type == .running))
            )
        }
        .onAppear {
            // 처음 불릴 때, 타이머 동작
            if timer == nil, rootManager.hasGeofence {
                startTimer()
            }
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }

    private var mypageButton: some View {
        Button(action: { self.mypagePresented = true }) {
            Image("menu")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
        }
    }

    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(
                withTimeInterval: 1.0,
                repeats: true,
                block: { _ in
                    showNewBadge = !badgeViewModel.badgeQueue.isEmpty
                    checkLevelUp()
                    let increase = 1
                    if challengeState.type == .running {
                        addChallengeTimer(increase: increase)
                    } else if challengeState.type == .outing {
                        addChallengeTimer(increase: increase)
                        addOutingTimer()
                    }
                }
            )
        }
    }

    func addChallengeTimer(increase: Int) {
        user.accumulateSeconds += increase
        shareViewModel.seconds += increase
        challengeState.seconds += increase
    }

    func addOutingTimer() {
        if flag {
            // 애니메이션 진입
            countTime -= 1
            if countTime == 0 {
                flag = false
            }
        } else {
            // 애니메이션 종료 후
            if challengeState.outingTimeDate.second <= 0 {
                if challengeState.outingTimeDate.minute <= 0 {
                    // 외출하기 시간 지남
                    // 이 로직을 돈다면 시간동안 범위 밖을 나가지 않음
                    flag = true
                    countTime = 3
                    if locationManager.isContains() {
                        print("위치가 맞음")
                        challengeState.type = .running
                    } else {
                        popupState.popupStyle = .failDuringOuting
                        popupState.isPresented = true
                        challengeState.type = .notAtHome
                    }

                } else {
                    challengeState.outingTimeDate.minute -= 1
                    challengeState.outingTimeDate.second = 59
                }
            } else {
                challengeState.outingTimeDate.second -= 1
            }
        }
    }

    /// 레벨업 체크
    func checkLevelUp() {
        let tier = Tier(level: user.level)
        let remains = tier.next() - user.accumulateSeconds
        if tier.next() == -1 {
            return
        }

        if remains <= 0 {
            user.level += 1
            let _tier = Tier(level: user.level)
            badgeViewModel.badgeQueue.append(
                Badge(
                    badgeType: .level,
                    badgeValue: "\(user.level)",
                    _name: "LV\(_tier.level) \(_tier.name())"
                )
            )
        }
    }

    private var stopButton: some View {
        Button(action: {
            self.popupState.popupStyle = .exit
            self.popupState.isPresented = true
        }) {
            Image("exit")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
        }
    }

    func confirmInPopup() {
        switch popupState.popupStyle {
        case .exit:
            sharePresented = true
            challengeState.type = .notRunning
            challengeState.seconds = 0

        case .fail:
            sharePresented = true
            challengeState.type = .notAtHome
            challengeState.seconds = 0

        case .outing:
            flag = true
            challengeState.outingTimeDate.minute = 19
            challengeState.outingTimeDate.second = 59
            challengeState.type = .outing
            if challengeState.numberOfHeart > 0 {
                challengeState.numberOfHeart -= 1
            }

        case .lackOfHeart:
            popupState.isPresented = false
        case .failDuringOuting:
            sharePresented = true
        }
    }

    private func setColor() -> Color {
        var color: Color
        let hours = user.accumulateSeconds / 3600
        switch challengeState.type {
        case .outing:
            color = Color.GrayScale._200
        case .notAtHome:
            color = Color.GrayScale._200

        default:
            let level = Tier.of(hours: hours).level

            switch level {
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
        }

        return color
    }

    private func setBottomView() -> AnyView {
        var view: AnyView
        switch challengeState.type {
        case .notAtHome:
            view = AnyView(BottomNotAtHome())
        case .running:
            view = AnyView(
                BottomTimerRunning(
                    numberOfHeart: $challengeState.numberOfHeart,
                    sharePresented: $sharePresented,
                    popupStyle: $popupState.popupStyle
                )
            )
        case .notRunning:
            view = AnyView(BottomTimerNotRunning(badgeViewModel: badgeViewModel))
        case .outing:
            view = AnyView(BottomOuting(count: $countTime, flag: $flag))
        }

        return view
    }
}

// MARK: - Timer_Previews

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        return Main()
            .environmentObject(PopupStateModel())
            .environmentObject(ChallengeState())
    }
}

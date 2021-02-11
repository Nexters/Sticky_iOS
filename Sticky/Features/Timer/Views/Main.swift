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

    @EnvironmentObject private var popupState: PopupStateModel
    @EnvironmentObject private var challengeState: ChallengeState
    @EnvironmentObject private var locationManager: LocationManager
    @EnvironmentObject private var user: User
    @EnvironmentObject private var badgeViewModel: BadgeViewModel

    @State var sharePresented: Bool = false
    @State var bannerDetailPresented: Bool = false
    @State var mypagePresented: Bool = false

    @State var color = Color.Palette.primary
    @State var timer: Timer? = nil
    @State static var isFirst: Bool = true
    @State var flag = true
    @State var countTime = 3

    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: Share(shareType: ShareType.slide),
                    isActive: $sharePresented
                ) { EmptyView() }
                NavigationLink(
                    destination: MyPage(),
                    isActive: $mypagePresented
                ) { EmptyView() }
                setColor()
                    .ignoresSafeArea()

                VStack {
                    Banner(
                        bannerDetailPresented: $bannerDetailPresented,
                        mypagePresented: $mypagePresented
                    )
                    Spacer()
                    TimerView(time: $challengeState.timeData)
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
                    badge: badgeViewModel.select
                )
                .isHidden(!bannerDetailPresented)
                .ignoresSafeArea(.all)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)

            .navigationBarItems(leading: mypageButton, trailing: stopButton.isHidden(!(challengeState.type == .running)))
        }
        .onAppear {
            // 처음 불릴 때, 타이머 동작
            print("onAppear")
            if Main.isFirst {
                Main.isFirst = false
                startTimer()
            }
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
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            /// 뱃지 획득 여부 체크

            if challengeState.type == .running {
                addChallengeTimer()
            } else if challengeState.type == .outing {
                addChallengeTimer()
                addOutingTimer()
            }

        })
    }

    func addChallengeTimer() {
        challengeState.timeData.second += 1
        if challengeState.timeData.minute >= 60 {
            challengeState.timeData.hour += 1
            challengeState.timeData.minute = 0
        } else if challengeState.timeData.second >= 60 {
            challengeState.timeData.minute += 1
            challengeState.timeData.second = 0
        }
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
                        // 누적 시간 저장
                        addAccumulateTime()
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

    func addAccumulateTime() {
        print("[누적시간 저장]")
        let seconds = Int(challengeState.startDate.timeIntervalSinceNow) * -1
        print("챌린지 시간: \(seconds)")
        user.accumulateSeconds += seconds
        user.thisMonthAccumulateSeconds += seconds
        print("내 정보:\(user.accumulateSeconds)")
        print("내 정보:\(user.thisMonthAccumulateSeconds)")
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
            addAccumulateTime()

        case .fail:
            sharePresented = true
            challengeState.type = .notAtHome
            addAccumulateTime()

        case .outing:
            flag = true
            challengeState.outingTimeDate.minute = 0
            challengeState.outingTimeDate.second = 9
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
        switch challengeState.type {
        case .outing:
            color = Color.GrayScale._500
        case .notAtHome:
            color = Color.GrayScale._500

        default:
            let level = Tier.of(hours: user.accumulateSeconds + challengeState.timeData.toSeconds()).level
            switch level{
            case 1:
                color = Color.Background.blue
            case 2:
                color = Color.Background.yellow
            case 3:
                color = Color.Background.green
            case 4:
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
            view = AnyView(BottomTimerRunning(numberOfHeart: $challengeState.numberOfHeart, sharePresented: $sharePresented, popupStyle: $popupState.popupStyle))
        case .notRunning:
            view = AnyView(BottomTimerNotRunning())
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

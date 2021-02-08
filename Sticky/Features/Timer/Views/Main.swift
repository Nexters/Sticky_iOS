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
    @State var sharePresented: Bool = false
    @State var color = Color.Palette.primary
    @State var selection: String? = ""
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
                NavigationLink(destination: MyPage(), tag: "mypage", selection: self.$selection) { EmptyView() }
                NavigationLink(destination: MyPage(), tag: "exit", selection: self.$selection) { EmptyView() }
                setColor()
                    .ignoresSafeArea()

                VStack {
                    scrollCardView

                    Spacer()
                    TimerView(time: $challengeState.timeData)

                    Spacer()

                    setBottomView()
                        .padding(.bottom, 24)
                }

                outingView
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
        Button(action: { self.selection = "mypage" }) {
            Image("menu")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            addSecond()
        })
    }

    func addSecond() {
        if challengeState.type == .running {
            if challengeState.timeData.minute >= 60 {
                challengeState.timeData.hour += 1
                challengeState.timeData.minute = 0
            } else if challengeState.timeData.second >= 60 {
                challengeState.timeData.minute += 1
                challengeState.timeData.second = 0
            }
            challengeState.timeData.second += 1
        } else if challengeState.type == .outing {
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
                            print("위치가 틀림")
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
    }

    private var outingView: Outing {
        Outing(timer: $timer, flag: $flag, countTime: $countTime)
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

            // MARK: 챌린지 종료하기

            sharePresented = true
//            challengeState.timeData = TimeData()

            challengeState.type = .notRunning
        case .fail:
            print("confirm fail")
            sharePresented = true
//            challengeState.timeData = TimeData()
            challengeState.type = .notAtHome
        case .outing:
            flag = true
            challengeState.outingTimeDate.minute = 0
            challengeState.outingTimeDate.second = 9
            challengeState.type = .outing
            challengeState.numberOfHeart -= 1
            print("외출하기")
        case .lockOfHeart:
            popupState.isPresented = false
        case .failDuringOuting:
            sharePresented = true
        }
    }

    // 획득 가능한 뱃지 리스트
    private var scrollCardView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button(action: {}) {
                    BannerItem(
                        title: "1 Hours",
                        subtitle: "23분 남음"
                    )
                }
                Button(action: {}) {
                    BannerItem(
                        title: "1 Hours",
                        subtitle: "23분 남음"
                    )
                }
                Button(action: {}) {
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

    private func setColor() -> Color {
        var color: Color
        switch challengeState.type {
        case .outing:
            color = Color.gray
        case .notAtHome:
            color = Color.gray

        default:
            color = Color.Background.blue
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

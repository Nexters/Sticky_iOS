//
//  Main.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import CoreLocation
import SwiftUI
import UserNotifications

// MARK: - TimerClass

class ChallengeState: ObservableObject {
    @Published var type: Main.ChallengeType = .notAtHome
}

// MARK: - Main

struct Main: View {
    enum ChallengeType: Int {
        case outing
        case notRunning
        case running
        case notAtHome
    }

    @EnvironmentObject private var popupState: PopupStateModel
    @EnvironmentObject private var time: Time
    @EnvironmentObject private var challengeState: ChallengeState
    @State var sharePresented: Bool = false
    @State var color = Color.Palette.primary
    @State var selection: String? = ""
    @State var timer: Timer? = nil
    @State static var isFirst: Bool = true
    @State var popupStyle: PopupStyle = .exit

    // 매 초 간격으로 main 쓰레드에서 공통 실행 루프에서 실행

    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: Share(),
                    isActive: $sharePresented
                ) { EmptyView() }
                NavigationLink(destination: MyPage(), tag: "mypage", selection: self.$selection) { EmptyView() }
                NavigationLink(destination: MyPage(), tag: "exit", selection: self.$selection) { EmptyView() }
                setColor()
                    .ignoresSafeArea()
                Image("blue_sticky")
                VStack {
                    Spacer()

                    scrollCardView

                    Spacer()
                    TimerView(time: $time.timeData)
                        .padding(.bottom, 87)

                    Spacer().frame(height: 100)

                    setBottomView()
                        .padding(.bottom, 24)
                }

                Outing(timer: $timer)
                    .isHidden(!(challengeState.type == .outing))

                PopupMessage(isPresented: $popupState.isPresented,
                             message: self.popupStyle.getMessage(),
                             confirmHandler: confirmInPopup,
                             rateOfWidth: 0.8)
                    .isHidden(!popupState.isPresented)
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(.all)
            .navigationBarItems(leading: mypageButton, trailing: stopButton.isHidden(!(challengeState.type == .running)))
        }
        .onAppear {
            // 처음 불릴 때, 타이머 동작
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
            if time.timeData.minute == 60 {
                time.timeData.hour += 1
                time.timeData.minute = 0
            } else if time.timeData.second == 60 {
                time.timeData.minute += 1
                time.timeData.second = 0
            }
            time.timeData.second += 1
        }
    }

    private var stopButton: some View {
        Button(action: {
            self.popupStyle = .exit
            self.popupState.isPresented = true
        }) {
            Image("exit")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
        }
    }

    func confirmInPopup() {
        switch popupStyle {
        case .exit:

            // MARK: 챌린지 종료하기

            print("종료하기")
        case .fail:
            sharePresented = true
        case .outing:

            // MARK: 챌린지 종료하기

            challengeState.type = .outing
            print("외출하기")
        }
    }

    private var scrollCardView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button(action: {}) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 172, height: 60)
                        .foregroundColor(Color.TextIconColor.secondary)
                        .overlay(
                            HStack {
                                Text("hi")
                            }
                        )
                }
                Button(action: {}) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 172, height: 60)
                        .foregroundColor(Color.TextIconColor.secondary)
                        .overlay(
                            HStack {
                                Text("hi")
                            }
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
            color = Color.Palette.primary
        }

        return color
    }

    private func setBottomView() -> AnyView {
        var view: AnyView
        switch challengeState.type {
        case .notAtHome:
            view = AnyView(BottomNotAtHome())
        case .running:
            view = AnyView(BottomTimerRunning(sharePresented: $sharePresented, popupStyle: $popupStyle))
        case .notRunning:
            view = AnyView(BottomTimerNotRunning())
        case .outing:
            view = AnyView(BottomOuting())
        }

        return view
    }
}

// MARK: - Timer_Previews

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        return Main()
            .environmentObject(PopupStateModel())
            .environmentObject(Time())
            .environmentObject(ChallengeState())
    }
}

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

class TimerClass: ObservableObject {
    @Published var type: Main.TimerType = .notRunning
}

// MARK: - Main

struct Main: View {
    enum TimerType: Int {
        case stop
        case notRunning
        case running
    }

    @EnvironmentObject private var popupState: PopupStateModel
    @EnvironmentObject private var time: Time
    @EnvironmentObject private var timerClass: TimerClass
    @State var sharePresented: Bool = false
    @State var color = Color.Palette.primary
    @State var selection: String? = ""
    @State var timer: Timer? = nil

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

                    Spacer()
                    TimerView(time: $time.timeData)
                        .padding(.bottom, 87)

//                setView()
//                GradientRoundedButton(
//                    content: "집에서만 시작할 수 있어요".localized,
//                    startColor: Color.GrayScale._600,
//                    endColor: Color.GrayScale._600,
//                    width: 328,
//                    height: 60,
//                    cornerRadius: 16.0,
//                    fontColor: Color.black
//                )
//                GradientRoundedButton(
//                    content: "집에서만 시작할 수 있어요".localized,
//                    startColor: Color.GrayScale._600,
//                    endColor: Color.GrayScale._600,
//                    width: 328,
//                    height: 60,
//                    cornerRadius: 16.0,
//                    fontColor: Color.black
//                )
                    Spacer().frame(height: 100)
                    Button(action: {
                        self.timerClass.type = .running
                    }) {
                        GradientRoundedButton(
                            content: "시작하기".localized,
                            startColor: Color.black,
                            endColor: Color.black,
                            width: 328,
                            height: 60,
                            cornerRadius: 16.0,
                            fontColor: Color.white
                        ).padding(.bottom, 24)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(.all)
            .navigationBarItems(leading: mypageButton, trailing: stopButton)
        }
//        .onReceive(timer) { _ in
//            if timerClass.type == .running {
//                if time.timeData.minute == 60 {
//                    time.timeData.hour += 1
//                    time.timeData.minute = 0
//                } else if time.timeData.second == 60 {
//                    time.timeData.minute += 1
//                    time.timeData.second = 0
//                }
//                time.timeData.second += 1
//            }
//        }
        // 항상이 아닌 경우 표시
        .onAppear {
                startTimer()

        }
        .popup(isPresented: $popupState.isPresented, rateOfWidth: 0.8) {
            PopupMessage(
                isPresented: $popupState.isPresented,
                title: "챌린지 종료하기",
                description: "챌린지가 00때문에 종료되었습니다.\n최종기록을 공유할까요",
                confirmString: "공유하기",
                rejectString: "취소하기"
            ) {
                self.sharePresented = true
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
        if timerClass.type == .running {
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
        Button(action: {}) {
            Image("exit")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
        }
    }

    func confirmInPopup() {
        sharePresented = true
    }

    private func setColor() -> Color {
        var color: Color
        switch timerClass.type {
        case .notRunning:
            fallthrough
        case .stop:
            color = Color.gray

        default:
            color = Color.Palette.primary
        }

        return color
    }

    private func setView() -> AnyView {
        var view: AnyView
        switch timerClass.type {
        case .stop:
            view = AnyView(TimerOff())

        case .running:
            view = AnyView(TimerRunning(sharePresented: $sharePresented))

        case .notRunning:
            view = AnyView(TimerNotRunning())
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
            .environmentObject(TimerClass())
    }
}

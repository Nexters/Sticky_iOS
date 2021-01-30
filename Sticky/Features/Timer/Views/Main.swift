//
//  Main.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

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
    @State var color = Color.main

    // 매 초 간격으로 main 쓰레드에서 공통 실행 루프에서 실행
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            NavigationLink(
                destination: Share(),
                isActive: $sharePresented
            ) { EmptyView() }

            setColor()
                .ignoresSafeArea()
            VStack {
                Spacer()
                TimerView(time: $time.timeData)
                    .padding(.bottom, 87)

                setView()
                Spacer().frame(height: 100)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 252, height: 74)
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 252, height: 74)
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 252, height: 74)
                    }
                }
                .padding(.leading, 16)
                .padding(.bottom, 20)
            }
            .navigationBarBackButtonHidden(true)
        }
        .onReceive(timer) { _ in
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
        .ignoresSafeArea(.all)
        .navigationBarItems(leading: mypageButton)
    }

    private var mypageButton: some View {
        NavigationLink(destination: MyPage()) {
            HStack {
                Image("menu")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
            }
        }
    }

    func confirmInPopup() {
        sharePresented = true
    }

    private func setColor() -> Color {
        var color: Color
        switch timerClass.type {
        case .stop:
            color = Color.gray

        default:
            color = Color.main
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
    }
}

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
    @State static var isFirst: Bool = true

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
                    


                    Spacer().frame(height: 100)

                    setBottomView()
                        .padding(.bottom, 24)
                }
                PopupMessage(isPresented: $popupState.isPresented, title: "타이틀", description: "설명", confirmString: "컨펌", rejectString: "리젝", confirmHandler: confirmInPopup, rateOfWidth: 0.8)
                    .opacity(popupState.isPresented ? 1 : 0)
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(.all)
            .navigationBarItems(leading: mypageButton, trailing: stopButton)
        }
        .onAppear {
            print("appear")
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
        print("setTimer")
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            addSecond()
        })
    }

    func addSecond() {
        print("add")
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

    private func setBottomView() -> AnyView {
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

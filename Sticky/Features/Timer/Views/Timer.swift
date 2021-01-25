//
//  Timer.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

struct Timer: View {
    enum TimerType: Int {
        case stop
        case notRunning
        case running
    }

    @EnvironmentObject private var popupState: PopupStateModel
    @State var sharePresented: Bool = false
    @State var isTimerOn = TimerType.notRunning
    @State var color = Color.main
    var body: some View {
        return NavigationView {
            ZStack {
                setColor()
                    .ignoresSafeArea()

                setView()
            }
            NavigationLink(destination: Share()
                .environmentObject(UIStateModel()),
                isActive: $sharePresented) { EmptyView() }
        }
        .popup(isPresented: $popupState.isPresented, rateOfWidth: 0.8) {
            PopupMessage(isPresented: $popupState.isPresented, title: "챌린지 종료하기", description: "챌린지가 00때문에 종료되었습니다.\n최종기록을 공유할까요", confirmString: "공유하기", rejectString: "취소하기") {
                self.sharePresented = true
            }
        }
        .ignoresSafeArea(edges: .all)
        .navigationBarHidden(true)
    }

    func confirmInPopup() {
        sharePresented = true
    }

    private func setColor() -> Color {
        var color: Color
        switch isTimerOn {
        case .stop:
            color = Color.gray

        default:
            color = Color.main
        }

        return color
    }

    private func setView() -> AnyView {
        var view: AnyView
        switch isTimerOn {
        case .stop:
            view = AnyView(TimerOff(isTimerOn: $isTimerOn))

        case .running:
            view = AnyView(TimerRunning(isTimerOn: $isTimerOn, sharePresented: $sharePresented))

        case .notRunning:
            view = AnyView(TimerNotRunning(isTimerOn: $isTimerOn))
        }

        return view
    }
}

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        return Timer()
            .environmentObject(PopupStateModel())
    }
}

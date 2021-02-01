//
//  TimerRunning.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/25.
//

import SwiftUI
import UserNotifications

// MARK: - TimerRunning

struct BottomTimerRunning: View {
    @EnvironmentObject private var popupState: PopupStateModel
    @EnvironmentObject var time: Time
    @EnvironmentObject private var timerClass: TimerClass
    @Binding var sharePresented: Bool
    @Binding var message: Message

    var body: some View {
        VStack {
            // share button
            Button(action: {
                self.popupState.isPresented = true
            }, label: {
                GradientRoundedButton(
                    content: "공유하기".localized,
                    startColor: Color.black,
                    endColor: Color.black,
                    width: 328,
                    height: 60,
                    cornerRadius: 16.0,
                    fontColor: Color.white
                )
            })
            // 외출하기 button
            Button(action: {
                self.message = PopupStyle.outing
                timerClass.type = .outing
            }, label: {
                BorderRoundedButton(text: "외출하기".localized, borderWidth: 1, borderColor: .black, fontColor: .black, width: 328, height: 60, cornerRadius: 16.0)
            })
        }
    }
}

// MARK: - TimerRunning_Previews

struct TimerRunning_Previews: PreviewProvider {
    static var previews: some View {
        BottomTimerRunning(sharePresented: .constant(true), message: .constant(PopupStyle.exit))
            .environmentObject(PopupStateModel())
            .environmentObject(Time())
    }
}

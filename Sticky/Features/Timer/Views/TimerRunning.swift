//
//  TimerRunning.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/25.
//

import SwiftUI
import UserNotifications

// MARK: - TimerRunning

struct TimerRunning: View {
    @EnvironmentObject private var popupState: PopupStateModel
    @EnvironmentObject var time: Time
    @EnvironmentObject private var timerClass: TimerClass
    @Binding var sharePresented: Bool

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
            // pause button
            Button(action: {
                timerClass.type = .stop
            }, label: {
                BorderRoundedButton(text: "외출하기".localized, borderWidth: 1, borderColor: .black, fontColor: .black, width: 328, height: 60, cornerRadius: 16.0)
            })
        }
    }
}

// MARK: - TimerRunning_Previews

struct TimerRunning_Previews: PreviewProvider {
    static var previews: some View {
        TimerRunning(sharePresented: .constant(true))
            .environmentObject(PopupStateModel())
            .environmentObject(Time())
    }
}

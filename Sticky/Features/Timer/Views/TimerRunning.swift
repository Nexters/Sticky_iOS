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
            HStack {
                // pause button
                Button(action: {
                    timerClass.type = .stop
                }, label: {
                    Circle()
                        .frame(width: 92, height: 92)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 10, x: 2, y: 2)
                        .overlay(
                            Image(systemName: "pause.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                        ).padding(.trailing, 60)
                })

                // share button
                Button(action: {
                    self.popupState.isPresented = true
                }, label: {
                    Circle()
                        .frame(width: 92, height: 92)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 10, x: 2, y: 2)
                        .overlay(
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        )
                })
            }
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

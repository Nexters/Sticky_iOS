//
//  TimerRunning.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/25.
//

import SwiftUI
import UserNotifications

// MARK: - BottomTimerRunning

struct BottomTimerRunning: View {
    @EnvironmentObject private var popupState: PopupStateModel
    @Binding var numberOfHeart: Int
    @Binding var sharePresented: Bool
    @Binding var popupStyle: PopupStyle

    var body: some View {
        VStack {
            // share button
            Button(action: {
                sharePresented = true
            }, label: {
                GradientRoundedButton(
                    content: "공유하기".localized,
                    startColor: Color.black,
                    endColor: Color.black,
                    width: 328,
                    height: 60,
                    cornerRadius: 16.0,
                    fontColor: Color.white,
                    icon: "ic_share"
                )
            })
            // 외출하기 button
            Button(action: {
                self.popupState.popupStyle = (numberOfHeart > 0) ? .outing : .lockOfHeart
                self.popupState.isPresented = true
            }, label: {
                BorderRoundedButton(
                    text: "외출하기".localized,
                    borderWidth: 1,
                    borderColor: Color.black.opacity(0.1),
                    fontColor: .black,
                    icon: "heart",
                    width: 328,
                    height: 60,
                    cornerRadius: 16.0
                )
            })
        }
    }
}

// MARK: - TimerRunning_Previews

struct TimerRunning_Previews: PreviewProvider {
    static var previews: some View {
        BottomTimerRunning(numberOfHeart: .constant(2), sharePresented: .constant(true), popupStyle: .constant(.exit))
            .environmentObject(PopupStateModel())
    }
}

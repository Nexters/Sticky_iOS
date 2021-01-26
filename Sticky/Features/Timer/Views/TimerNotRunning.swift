//
//  TimerOn.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/25.
//

import SwiftUI

// MARK: - TimerNotRunning

struct TimerNotRunning: View {
    // MARK: Internal

    @EnvironmentObject var time: Time

    var body: some View {
        VStack {
//                NavigationLink(destination: MyPage()) {
//                    Text("MyPage")
//                }

//                Button(action: {
//                    popupState.isPresented = true
//                }, label: {
//                    Text("팝업")
//                })

            Button(action: {
                timerClass.type = .running
            }, label: {
                Circle()
                    .frame(width: 92, height: 92)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 10, x: 2, y: 2)
                    .overlay(
                        Image(systemName: "play.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.leading, 10)
                    )
            })
        }
    }

    // MARK: Private

    @EnvironmentObject private var timerClass: TimerClass
}

// MARK: - TimerNotRunning_Previews

struct TimerNotRunning_Previews: PreviewProvider {
    static var previews: some View {
        TimerNotRunning()
    }
}

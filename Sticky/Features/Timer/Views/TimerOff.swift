//
//  TimerOff.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/25.
//

import SwiftUI

// MARK: - TimerOff

struct TimerOff: View {
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

                UserDefaults.standard.set(Date(), forKey: "startDate")
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

// MARK: - TimerOff_Previews

struct TimerOff_Previews: PreviewProvider {
    static var previews: some View {
        TimerOff()
    }
}

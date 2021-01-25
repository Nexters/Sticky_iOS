//
//  TimerRunning.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/25.
//

import SwiftUI

struct TimerRunning: View {
    @EnvironmentObject private var popupState: PopupStateModel
    @Binding var isTimerOn: Timer.TimerType
    @Binding var sharePresented: Bool
    var body: some View {
        VStack {
            Spacer()

            VStack {
                Text("0일")
                    .font(.system(size: 40))
                    .foregroundColor(.white)

                Text("00:00")
                    .font(.system(size: 80))
                    .bold()
                    .foregroundColor(.white)

                Text("00")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }
            .padding()
            Spacer()

            HStack {
                Button(action: {
                    self.isTimerOn = .stop
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
                        )
                        .padding(.bottom, 170)
                        .padding(.trailing, 20)
                })

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
                        .padding(.bottom, 170)
                        .padding(.leading, 20)
                })
            }
        }
    }
}

struct TimerRunning_Previews: PreviewProvider {
    static var previews: some View {
        TimerRunning(isTimerOn: .constant(Timer.TimerType.running), sharePresented: .constant(true))
            .environmentObject(PopupStateModel())
    }
}

//
//  TimerOff.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/25.
//

import SwiftUI

struct TimerOff: View {
    @Binding var isTimerOn: Timer.TimerType
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

            Button(action: {
                self.isTimerOn = .running
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
                    .padding(.bottom, 170)
            })
            
        }
    }
}

struct TimerOff_Previews: PreviewProvider {
    static var previews: some View {
        TimerOff(isTimerOn: .constant(Timer.TimerType.stop))
    }
}

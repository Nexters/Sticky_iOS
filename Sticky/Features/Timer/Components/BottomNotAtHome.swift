//
//  TimerOff.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/25.
//

import SwiftUI

// MARK: - TimerOff

struct BottomNotAtHome: View {
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

            Button(action: {}, label: {
                GradientRoundedButton(
                    content: "집에서만 시작할 수 있어요".localized,
                    startColor: Color.gray,
                    endColor: Color.gray,
                    width: 328,
                    height: 60,
                    cornerRadius: 16.0,
                    fontColor: Color.black
                )
            })
        }
    }
}

// MARK: - TimerOff_Previews

struct TimerOff_Previews: PreviewProvider {
    static var previews: some View {
        BottomNotAtHome()
    }
}

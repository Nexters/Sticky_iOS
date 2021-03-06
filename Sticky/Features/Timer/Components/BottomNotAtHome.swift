//
//  TimerOff.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/25.
//

import SwiftUI

// MARK: - BottomNotAtHome

struct BottomNotAtHome: View {
    var body: some View {
        VStack {
            Button(action: {}, label: {
                GradientRoundedButton(
                    content: "집에서만 시작할 수 있어요",
                    startColor: Color.gray,
                    endColor: Color.gray,
                    width: 328,
                    height: 60,
                    cornerRadius: 16.0,
                    fontColor: Color.white
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

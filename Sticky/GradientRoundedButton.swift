//
//  RoundedButton.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import SwiftUI

struct GradientRoundedButton: View {
    var content: String
    var startColor: Color
    var endColor: Color
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: width, height: height)
                .foregroundColor(.clear)
                .background(LinearGradient(
                    gradient: Gradient(
                        colors: [startColor, endColor]
                    ),
                    startPoint: .leading,
                    endPoint: .trailing
                ))
            Text(content)
                .foregroundColor(.white)
                .bold()
        }.cornerRadius(24)
    }
}

struct GradientRoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        GradientRoundedButton(
            content: "시작하기".localized,
            startColor: Color.gradientStart,
            endColor: Color.gradientEnd,
            width: 312,
            height: 48
        )
    }
}

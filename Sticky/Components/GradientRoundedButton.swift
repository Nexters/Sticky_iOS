//
//  RoundedButton.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import SwiftUI

// MARK: - GradientRoundedButton

struct GradientRoundedButton: View {
    var content: String
    var startColor: Color
    var endColor: Color
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat = 24
    var fontColor: Color = .white

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
                .foregroundColor(fontColor)
                .bold()
        }.cornerRadius(cornerRadius)
    }
}

// MARK: - GradientRoundedButton_Previews

struct GradientRoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        GradientRoundedButton(
            content: "시작하기".localized,
            startColor: Color.Palette.primary,
            endColor: Color.Palette.secondary,
            width: 312,
            height: 48
        )
    }
}

//
//  RoundedButton.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import SwiftUI

// MARK: - BorderRoundedButton

struct BorderRoundedButton: View {
    var text: String
    var borderWidth: CGFloat
    var borderColor: Color
    var fontColor: Color
    var icon: String = ""
    var width: CGFloat?
    var height: CGFloat?
    var cornerRadius: CGFloat?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius ?? 24.0)
                .stroke(borderColor, lineWidth: borderWidth)
                .frame(maxWidth: width ?? .infinity, maxHeight: height ?? 48.0)
            HStack {
                Image(icon)
                    .foregroundColor(fontColor)
                Text(text)
                    .fontWeight(.bold)
                    .foregroundColor(fontColor)
            }
        }
    }
}

// MARK: - BorderRoundedButton_Previews

struct BorderRoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        BorderRoundedButton(
            text: "현재 위치로 주소 찾기",
            borderWidth: 2.0,
            borderColor: Color.GrayScale._200,
            fontColor: .black,
            icon: "aim"
        )
    }
}

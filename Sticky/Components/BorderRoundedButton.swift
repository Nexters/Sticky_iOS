//
//  RoundedButton.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import SwiftUI

struct BorderRoundedButton: View {
    var text: String
    var borderWidth: CGFloat
    var borderColor: Color
    var fontColor: Color
    var icon: String = ""
    var width: CGFloat = 312.0
    var height: CGFloat = 48.0
    var cornerRadius: CGFloat = 24.0

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: borderWidth)
                .frame(width: width, height: height)
            HStack {
                Text(text)
                    .fontWeight(.bold)
                    .foregroundColor(fontColor)
                Image(icon)
            }
        }
    }
}

struct BorderRoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        BorderRoundedButton(
            text: "현재 위치로 주소 찾기",
            borderWidth: 2.0,
            borderColor: Color.gray200,
            fontColor: .black,
            icon: "aim"
        )
    }
}

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

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .stroke(borderColor, lineWidth: borderWidth)
                .frame(width: 312.0, height: 48.0)
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

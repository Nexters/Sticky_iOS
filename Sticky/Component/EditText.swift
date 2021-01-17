//
//  EditTextView.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import SwiftUI

struct EditText: View {
    @Binding var input: String
    var placeholder: String
    var width: CGFloat
    var height: CGFloat
    var radius: CGFloat

    var body: some View {
        HStack(alignment: .center) {
            TextField("", text: $input)
                .accentColor(.gray)
                .modifier(
                    PlaceholderStyle(
                        showPlaceHolder: input.isEmpty,
                        placeholder: placeholder
                    )
                )
        }
        .padding()
        .frame(width: width, height: height)
        .background(
            RoundedRectangle(cornerRadius: radius)
                .foregroundColor(
                    Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.05)
                )
        )
    }
}

struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 15)
            }
            content
                .foregroundColor(Color.black)
                .padding(5.0)
        }
    }
}

struct EditTextView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State var input: String = ""

        var body: some View {
            EditText(
                input: $input,
                placeholder: "도로명, 건물명 또는 지번으로 검색",
                width: 312.0,
                height: 48.0,
                radius: 12.0
            )
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}

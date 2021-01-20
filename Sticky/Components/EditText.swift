//
//  EditTextView.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import SwiftUI

struct EditText: View {
    @Binding var input: String

    @State private var isEditing = false

    var placeholder: String
    var width: CGFloat
    var height: CGFloat
    var radius: CGFloat
    var accentColor: Color = .white

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
                .onTapGesture {
                    self.isEditing = true
                }
            if isEditing {
                withAnimation {
                    Button(action: {
                        withAnimation {
                            self.isEditing.toggle()
                            self.input = ""
                            // Dismiss the keyboard
                            UIApplication.shared.sendAction(
                                #selector(UIResponder.resignFirstResponder),
                                to: nil, from: nil, for: nil
                            )
                        }
                    }, label: {
                        Image("ic_close_small")
                    })
                }
            }
        }
        .padding()
        .frame(width: width, height: height)
        .background(
            RoundedRectangle(cornerRadius: radius)
                .foregroundColor(
                    accentColor
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
                    .multilineTextAlignment(.leading)
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
            ZStack {
                Color.gray.ignoresSafeArea()
                EditText(
                    input: $input,
                    placeholder: "도로명, 건물명 또는 지번으로 검색",
                    width: 312.0,
                    height: 48.0,
                    radius: 12.0
                )
            }
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}

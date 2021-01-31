//
//  EditTextView.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import SwiftUI

// MARK: - EditText

struct EditText: View {
    @Binding var input: String
    @State private var isEditing = false
    @State var placeholder: String

    var width: CGFloat?
    var height: CGFloat?
    var radius: CGFloat?
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

            if isEditing {
                withAnimation {
                    Button(action: {
                        withAnimation {
                            self.isEditing.toggle()
                            self.input = ""
                            self.placeholder = "도로명, 건물명 또는 지번으로 검색"
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
        }.onTapGesture {
            self.isEditing = true
            self.placeholder = ""
        }
        .padding()
        .frame(
            maxWidth: self.width ?? .infinity,
            maxHeight: self.height ?? 48
        )
        .background(
            RoundedRectangle(cornerRadius: self.radius ?? 12)
                .stroke(Color.black, lineWidth: 1)
                .foregroundColor(
                    accentColor
                )
        )
    }
}

// MARK: - PlaceholderStyle

struct PlaceholderStyle: ViewModifier {
    // MARK: Public

    public func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            content
                .foregroundColor(Color.black)
                .padding(5.0)
        }
    }

    // MARK: Internal

    var showPlaceHolder: Bool
    var placeholder: String
}

// MARK: - EditTextView_Previews

struct EditTextView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State var input: String = ""

        var body: some View {
            ZStack {
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

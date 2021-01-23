//
//  Alert.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/23.
//

import SwiftUI

struct Popup: ViewModifier {
    let size: CGSize?
    let title: String
    let description: String
    let confirmString: String
    let rejectString: String

    init(
        size: CGSize? = nil,
        title: String,
        description: String,
        confirmString: String,
        rejectString: String
    ) {
        self.size = size
        self.title = title
        self.description = description
        self.confirmString = confirmString
        self.rejectString = rejectString
    }

    func body(content: Content) -> some View {
        content
            .blur(radius: 1)
            .overlay(Rectangle()
                .fill(Color.black.opacity(0.7)))
            .overlay(popupContent)
    }

    private var popupContent: some View {
        GeometryReader { gr in
            VStack(alignment: .center) {
                Text(self.title)
                    .font(.system(size: 22))
                    .bold()
                    .padding(.bottom, 16)

                Text(self.description)
                    .lineSpacing(2)
                    .font(.system(size: 20))
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)

                Button(action: {
                    // 확인 클릭
                }, label: {
                    Rectangle()
                        .overlay(Text(self.confirmString)
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(.white))
                        .cornerRadius(30)
                        .frame(maxHeight: 60)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 32)

                })
                    .padding(.top, 20)

                Button(action: {
                    // 취소 클릭
                }, label: {
                    Rectangle()
                        .overlay(Text(self.rejectString)
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(.black))
                        .cornerRadius(30)
                        .frame(maxHeight: 60)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                })
                .padding(.top, 5)
            }
            .frame(width: gr.size.width * 0.4, height: gr.size.height * 0.43)
            .background(Color.primary.colorInvert())
            .cornerRadius(20)
            .shadow(color: .gray, radius: 15, x: 5, y: 5)
            .position(x: gr.frame(in: .local).midX, y: gr.frame(in: .local).midY)
        }
    }
}

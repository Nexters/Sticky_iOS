//
//  PopupMessage.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/24.
//

import SwiftUI

// MARK: - PopupMessage

struct PopupMessage: View {
    @Binding var isPresented: Bool
    let message: Message
    let confirmHandler: () -> Void
    let rateOfWidth: CGFloat

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black.opacity(0.7)).blur(radius: 1)
            GeometryReader { gr in
                VStack(alignment: .center) {
                    Text(self.message.title)
                        .font(.system(size: 22))
                        .bold()
                        .padding(.bottom, 16)

                    Text(self.message.description)
                        .lineSpacing(2)
                        .font(.system(size: 20))
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.center)

                    HStack {
                        Image("heart")
                            .foregroundColor(.red)
                        Text("보유갯수/3")
                            .foregroundColor(.red)
                            .font(.system(size: 32))
                    }.isHidden(message.style != .outing, remove: message.style != .outing)

                    Button(action: {
                        self.isPresented = false
                        self.confirmHandler()
                    }, label: {
                        Rectangle()
                            .overlay(Text(self.message.confirmString)
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
                        self.isPresented = false
                    }, label: {
                        Rectangle()
                            .overlay(Text(self.message.rejectString)
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
                .frame(width: gr.size.width * self.rateOfWidth, height: gr.size.height * 0.43)
                .background(Color.primary.colorInvert())
                .cornerRadius(20)
                .shadow(color: .gray, radius: 15, x: 5, y: 5)
                .position(x: gr.frame(in: .local).midX, y: gr.frame(in: .local).midY)
            }
        }
    }
}

// MARK: - PopupMessage_Previews

struct PopupMessage_Previews: PreviewProvider {
    static var previews: some View {
        PopupMessage(isPresented: .constant(false), message: Message(style: .exit, title: "타이틀", description: "설명\n설명", confirmString: "확인", rejectString: "취소"), confirmHandler: {}, rateOfWidth: 0.8)
    }
}

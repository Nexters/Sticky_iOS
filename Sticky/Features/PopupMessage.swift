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
    @Binding var numberOfHeart: Int
    let message: Message
    let confirmHandler: () -> Void
    let rateOfWidth: CGFloat

    var body: some View {
        ZStack {
            Color.black.opacity(0.6).ignoresSafeArea()
            VStack(alignment: .center) {
                Text(self.message.title)
                    .font(.system(size: 17)).bold()
                    .frame(height: 24)
                    .padding(.bottom, 8)

                Text(self.message.description)
                    .kerning(-0.3)
                    .lineSpacing(4)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.bottom, 16)

                HStack {
                    Image("ic_heart")
                    Text("\(self.numberOfHeart)/3")
                        .font(.system(size: 24))
                        .foregroundColor(Color.Palette.negative)
                }
                .padding(.bottom, 16)
                .isHidden(
                    message.style != .outing,
                    remove: message.style != .outing
                )

                Button(action: {
                    self.isPresented = false
                    self.confirmHandler()
                }, label: {
                    RoundedRectangle(cornerRadius: 16)
                        .overlay(
                            HStack {
                                Text(self.message.confirmString)
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        )
                        .frame(height: 48)
                        .foregroundColor(
                            self.message.style == PopupStyle.exit ?
                                Color.Palette.primary : Color.black
                        )

                }).padding(.bottom, 8)

                Button(action: {
                    self.isPresented = false
                }, label: {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                        .overlay(Text(self.message.rejectString)
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(.black))
                        .frame(height: 48)
                        .foregroundColor(.white)
                }).isHidden(message.rejectString == "")
            }
            .frame(width: 288)
            .padding(24)
            .background(Color.primary.colorInvert())
            .cornerRadius(24)
            .shadow(color: Color.black.opacity(0.24), radius: 15, x: 0, y: 4)
            .position(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        }
    }
}

// MARK: - PopupMessage_Previews

struct PopupMessage_Previews: PreviewProvider {
    static var previews: some View {
        PopupMessage(
            isPresented: .constant(false), numberOfHeart: .constant(1),
            message: Message(
                style: .exit,
                title: "챌린지 종료하기",
                description: "앗! 지금까지의 쌓은 연속기록이 사라집니다!\n정말 챌린지를 종료하시겠어요?",
                confirmString: "그만 할래요",
                rejectString: "계속 할게요"
            ),
            confirmHandler: {},
            rateOfWidth: 0.8
        )
    }
}

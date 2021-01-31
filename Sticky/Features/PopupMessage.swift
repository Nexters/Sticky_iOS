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
    let title: String
    let description: String
    let confirmString: String
    let rejectString: String
    let confirmHandler: () -> Void
    let rateOfWidth: CGFloat

    var body: some View {
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
                    self.isPresented = false
                    self.confirmHandler()
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
                    self.isPresented = false
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
            .frame(width: gr.size.width * (self.rateOfWidth ?? CGFloat(0.8)), height: gr.size.height * 0.43)
                .background(Color.primary.colorInvert())
                .cornerRadius(20)
                .shadow(color: .gray, radius: 15, x: 5, y: 5)
                .position(x: gr.frame(in: .local).midX, y: gr.frame(in: .local).midY)
        }
    }
}

// MARK: - PopupMessage_Previews

struct PopupMessage_Previews: PreviewProvider {
    static var previews: some View {
        PopupMessage(isPresented: .constant(false), title: "타이틀", description: "설명\n설명", confirmString: "확인", rejectString: "취소", confirmHandler: {}, rateOfWidth: 0.8)
    }
}

//
//  Modal.swift
//  Sticky
//
//  Created by deo on 2021/02/08.
//

import SwiftUI

// MARK: - ModalView

struct ModalView: View {
    @Binding var isPresented: Bool
    let confirmHandler: () -> Void
    var title: String
    var description: String
    var ok: String
    var okButtonColor: Color
    var cancel: String

    var body: some View {
        ZStack {
            Color.black.opacity(0.6).ignoresSafeArea()
            VStack(alignment: .center) {
                Text(self.title)
                    .font(.system(size: 17)).bold()
                    .frame(height: 24)
                    .padding(.bottom, 8)

                Text(self.description)
                    .kerning(-0.3)
                    .lineSpacing(4)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .padding(.bottom, 16)

                Button(action: {
                    self.isPresented = false
                    self.confirmHandler()
                }, label: {
                    RoundedRectangle(cornerRadius: 16)
                        .overlay(
                            HStack {
                                Text(self.ok)
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        )
                        .frame(height: 48)
                        .foregroundColor(okButtonColor)

                }).padding(.bottom, 8)

                Button(action: {
                    self.isPresented = false
                }, label: {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                        .overlay(Text(self.cancel)
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(.black))
                        .frame(height: 48)
                        .foregroundColor(.white)
                })
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

// MARK: - ModalView_Previews

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(
            isPresented: .constant(false),
            confirmHandler: { print("hi") },
            title: "",
            description: "",
            ok: "",
            okButtonColor: Color.black,
            cancel: ""
        )
    }
}

//
//  Alert.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/23.
//

import SwiftUI

struct Popup<Message: View>: ViewModifier {
    let rateOfWidth: CGFloat?
    let message: Message

    init(
        rateOfWidth: CGFloat?,
        message: Message
    ) {
        self.rateOfWidth = rateOfWidth
        self.message = message
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
            message
                .frame(width: gr.size.width * (self.rateOfWidth ?? CGFloat(0.8)), height: gr.size.height * 0.43)
                .background(Color.primary.colorInvert())
                .cornerRadius(20)
                .shadow(color: .gray, radius: 15, x: 5, y: 5)
                .position(x: gr.frame(in: .local).midX, y: gr.frame(in: .local).midY)
        }
    }
}

private struct PopupToggle: ViewModifier {
    @Binding var isPresented: Bool
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func popup<Content: View>(isPresented: Binding<Bool>,
                              rateOfWidth: CGFloat?,
                              @ViewBuilder content: () -> Content) -> some View
    {
        if isPresented.wrappedValue {
            let popup = Popup(rateOfWidth: rateOfWidth ?? 0.8, message: content())
            let popupToggle = PopupToggle(isPresented: isPresented)
            let modifiedContent = modifier(popup).modifier(popupToggle)
            return AnyView(modifiedContent)
        } else {
            return AnyView(self)
        }
    }
}

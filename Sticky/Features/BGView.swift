//
//  BGView.swift
//  Sticky
//
//  Created by 지현우 on 2021/02/15.
//

import SwiftUI

// MARK: - BGView

struct BGView: View {
    var color: LinearGradient?
    var image = Image("congratulationBg")

    var body: some View {
        ZStack {
            AnyView(color?.ignoresSafeArea())
            image
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)
                .ignoresSafeArea()
                .isHidden(color != nil)
        }
    }
}

// MARK: - BGView_Previews

struct BGView_Previews: PreviewProvider {
    static var previews: some View {
        BGView(color: Color.Sticky.blue)
    }
}

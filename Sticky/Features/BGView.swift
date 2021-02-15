//
//  BGView.swift
//  Sticky
//
//  Created by 지현우 on 2021/02/15.
//

import SwiftUI

struct BGView: View {
    var color: LinearGradient
    var body: some View {
        AnyView(color.ignoresSafeArea())
    }
}

struct BGView_Previews: PreviewProvider {
    static var previews: some View {
        BGView(color: Color.Sticky.blue)
    }
}

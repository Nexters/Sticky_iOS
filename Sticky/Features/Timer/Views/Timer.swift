//
//  Timer.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

struct Timer: View {
    var body: some View {
        VStack {
            NavigationLink(destination: MyPage()) {
                Text("MyPage")
            }
        }.navigationBarHidden(true)
    }
}

struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        Timer()
    }
}

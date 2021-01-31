//
//  Outing.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/31.
//

import SwiftUI

// MARK: - Outing

struct Outing: View {
    @Binding var timer: Timer?

    var body: some View {
        ZStack {
            Color.red

            VStack {
                Text("외출중!!!! 화면 구현해야함")

                BottomOuting()
            }
        }
    }
}

// MARK: - Outing_Previews

struct Outing_Previews: PreviewProvider {
    static var previews: some View {
        Outing(timer: .constant(Timer()))
    }
}

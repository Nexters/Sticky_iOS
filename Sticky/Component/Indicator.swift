//
//  Indicator.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import SwiftUI

struct Indicator: View {
    var currentIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0 ..< 3, id: \.self) { index in
                Circle()
                    .frame(width: index == self.currentIndex ? 10 : 8,
                           height: index == self.currentIndex ? 10 : 8)
                    .foregroundColor(index == self.currentIndex ? Color.blue : .gray)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    .padding(.bottom, 8)
            }
        }
    }
}

struct Indicator_Previews: PreviewProvider {
    static var previews: some View {
        Indicator(currentIndex: 1)
    }
}

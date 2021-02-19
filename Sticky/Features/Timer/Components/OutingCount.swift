//
//  OutingCount.swift
//  Sticky
//
//  Created by 지현우 on 2021/02/01.
//

import SwiftUI

// MARK: - OutingCount

struct OutingCount: View {
    @Binding var count: Int

    var body: some View {
        ZStack {
            Color.Background.outing
                .ignoresSafeArea()
            Text("\(count)")
                .font(.custom("Modak", size: 96))
                .foregroundColor(.white)
                .bold()
        }
    }
}

// MARK: - OutingCount_Previews

struct OutingCount_Previews: PreviewProvider {
    static var previews: some View {
        OutingCount(count: .constant(3))
    }
}

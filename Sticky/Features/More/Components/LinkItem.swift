//
//  LinkItem.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

// MARK: - LinkItem

struct LinkItem: View {
    let text: String

    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 16))
            Spacer()
            Image("arrow_right")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
        }.frame(height: 60)
    }
    
}

// MARK: - LinkItem_Previews

struct LinkItem_Previews: PreviewProvider {
    static var previews: some View {
        LinkItem(text: "hi")
            .border(Color.black, width: 1)
            .padding()
    }
}

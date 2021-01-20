//
//  SearchResult.swift
//  Sticky
//
//  Created by deo on 2021/01/20.
//

import SwiftUI

struct Result: View {
    var body: some View {
        List {
            ForEach(0 ..< 10, id: \.self) { _ in
                AddressItem(
                    address1: "서울특별시 마포구 신촌로 2길",
                    address2: "서울특별시 마포구 신촌로 2길"
                )
            }
        }
    }
}

struct Result_Previews: PreviewProvider {
    static var previews: some View {
        Result()
    }
}

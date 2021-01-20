//
//  AddressItem.swift
//  Sticky
//
//  Created by deo on 2021/01/20.
//

import SwiftUI

struct AddressItem: View {
    var address1: String
    var address2: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(address1)
                .font(.system(size: 16))
                .frame(width: 312, alignment: .leading)
                .lineLimit(2)
            Text(address2)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .frame(width: 312, alignment: .leading)
                .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        }.frame(width: 360, height: 80)
    }
}

struct AddressItem_Previews: PreviewProvider {
    static var previews: some View {
        AddressItem(
            address1: "도로명주소도로명주소도로명주소도로명주소도로명주소도로명주소도로명주소도로명주소도로명주소",
            address2: "지번주소지번주소지번주소지번주소지번주소지번주소지번주소지번주소지번주소지번주소지번주소"
        )
    }
}

//
//  SearchAddress.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import SwiftUI

struct SearchAddress: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var input: String = ""

    var body: some View {
        VStack {
            Text("집이 어디인가요?🏠")
                .font(.system(size: 28))
                .bold()
                .frame(width: 312, height: 36, alignment: .leading)
                .padding(.bottom, 16)

            EditText(
                input: $input,
                placeholder: "도로명, 건물명 또는 지번으로 검색".localized,
                width: 312.0,
                height: 48.0,
                radius: 12.0
            )
            .padding(.bottom, 30)

            BorderRoundedButton(
                text: "현재 위치로 주소 찾기",
                borderWidth: 2.0,
                borderColor: Color.gray200,
                fontColor: .black,
                icon: "aim"
            )
            .padding(.bottom, 38)

            Rectangle()
                .fill(Color.grayC4)
                .frame(height: 10)
                .edgesIgnoringSafeArea(.horizontal)

            List {
                ForEach(0 ..< 10, id: \.self) { _ in
                    AddressItem(address1: "서울특별시 마포구 신촌로 2길", address2: "서울특별시 마포구 신촌로 2길")
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }

    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image("left-arrow")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        }
    }
}

struct AddressItem: View {
    var address1: String
    var address2: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(address1)
                .font(.system(size: 16))
                .frame(width: 312, alignment: .leading)
            Text(address2)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .frame(width: 312, alignment: .leading)
        }.frame(width: 312, height: 80)
    }
}

struct SearchAddress_Previews: PreviewProvider {
    static var previews: some View {
        SearchAddress()
    }
}

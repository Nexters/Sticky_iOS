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
            ZStack {
                Color.main
                    .ignoresSafeArea()

                VStack {
                    Text("집 주소를 입력해주세요")
                        .font(.system(size: 28))
                        .bold()
                        .frame(width: 312, height: 36, alignment: .leading)
                        .padding(.bottom, 16)

                    EditText(
                        input: $input,
                        placeholder: "도로명, 건물명 또는 지번으로 검색",
                        width: 312.0,
                        height: 48.0,
                        radius: 12.0,
                        accentColor: .white
                    )
                    .padding(.bottom, 30)
                    NavigationLink(destination: SearchResult()) {
                        BorderRoundedButton(
                            text: "현재 위치로 주소 찾기",
                            borderWidth: 2.0,
                            borderColor: Color.gray200,
                            fontColor: .white,
                            icon: "ic_here"
                        )
                    }
                }
            }.frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: 257,
                alignment: .center
            )
            .foregroundColor(.white)
            Tip().padding(.top, 20)
//            NotFound().padding(.top, 20)
//            Result()
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }

    var backButton: some View {
        Button(action: focusRelease) {
            HStack {
                Image("left-arrow")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        }
    }

    func focusRelease() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SearchAddress_Previews: PreviewProvider {
    static var previews: some View {
        SearchAddress()
    }
}

//
//  SearchResult.swift
//  Sticky
//
//  Created by deo on 2021/01/20.
//

import SwiftUI

struct SearchResult: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack {
            Color.main.ignoresSafeArea()
            VStack {
                Map()
                    .padding(.bottom, 30)

                Text("반포 자이아파트")
                    .font(.system(size: 24))
                    .bold()
                    .padding(.bottom, 8)

                Text("주소는 말줄임 없이 줄바꿈으로 무한대~주소는 말줄임 없이 줄바꿈으로 무한대~주소는 말줄임 없이 줄바꿈으로 무한대~주소는 말줄임 없이 줄바꿈으로 무한대~")
                    .font(.system(size: 16))
                    .frame(width: 280, height: .infinity)
                    .padding(.bottom, 46)

                NavigationLink(destination: EmptyView()) {
                    GradientRoundedButton(
                        content: "집으로 설정하기".localized,
                        startColor: Color.black,
                        endColor: Color.black,
                        width: 202,
                        height: 48
                    )
                    .padding(.bottom, 20)
                }

                Button(action: focusRelease) {
                    Text("여기가 아닌가요?")
                        .foregroundColor(.white)
                        .underline()
                }
            }
            .padding(.leading, 24)
            .padding(.trailing, 24)
            .foregroundColor(.white)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
        }
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
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct SearchResult_Previews: PreviewProvider {
    static var previews: some View {
        SearchResult()
    }
}

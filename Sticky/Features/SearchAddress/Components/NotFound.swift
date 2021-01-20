//
//  NotFound.swift
//  Sticky
//
//  Created by deo on 2021/01/20.
//

import SwiftUI

struct NotFound: View {
    var body: some View {
        VStack {
            Spacer()
            Image("ic_search")
            Text("검색 결과가 없습니다.\n지번, 도로명, 건물명을 입력해주세요.")
                .lineSpacing(10)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}

struct NotFound_Previews: PreviewProvider {
    static var previews: some View {
        NotFound()
    }
}

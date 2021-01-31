//
//  Tip.swift
//  Sticky
//
//  Created by deo on 2021/01/20.
//

import SwiftUI

// MARK: - Tip

struct Tip: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Tip")
                    .font(.system(size: 16))
                    .bold()
                Spacer()
            }
            .padding(.bottom, 8)
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 0) {
                    Text("- 도로명 ").padding(.trailing, 0)
                    Text("+ 건물번호 ").bold()
                    Text("(예: 강남대로 570)")
                        .foregroundColor(.gray)
                }
                HStack(spacing: 0) {
                    Text("- 동/읍/면/리 ")
                    Text("+ 번지 ").bold()
                    Text("(예: 신천동 42)")
                        .foregroundColor(.gray)
                }
                HStack(spacing: 0) {
                    Text("- 건물명, 아파트명 ")
                    Text("(예: 반포자이아파트)")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

// MARK: - Tip_Previews

struct Tip_Previews: PreviewProvider {
    static var previews: some View {
        Tip()
    }
}

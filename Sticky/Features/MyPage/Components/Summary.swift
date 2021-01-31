//
//  Summary.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

// MARK: - Summary

struct Summary: View {
    var level: Int = 0

    var body: some View {
        VStack(alignment: .trailing) {
            Text("등급정보")
                .underline()
                .foregroundColor(.gray)
            HStack(alignment: .top) {
                Spacer()
                VStack {
                    Rectangle()
                        .frame(width: 140, height: 140)
                        .padding(.bottom, 16)
                    // 레벨 변환
                    Text("LV. \(level) 지박령")
                        .font(.system(size: 24))
                        .bold()
                        .padding(.bottom, 8)
                    // 현재 누적 시간
                    Text("94일 23시간 48분")
                        .font(.system(size: 20))

                    // 다음 레벨 계산
                    Text("다음 레벨까지 40시간 남았습니다")
                        .foregroundColor(Color.GrayScale._600)
                }
                Spacer()
            }
        }
    }
}

// MARK: - Summary_Previews

struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.GrayScale._100.ignoresSafeArea()
            Summary(level: 3)
                .border(Color.black)
        }
    }
}

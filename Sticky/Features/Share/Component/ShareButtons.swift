//
//  ShareButtons.swift
//  Sticky
//
//  Created by deo on 2021/02/01.
//

import SwiftUI

// MARK: - ShareButtons

struct ShareButtons: View {
    @EnvironmentObject var UIState : UIStateModel
    var body: some View {
        HStack(spacing: 48) {
            Rectangle()
                .overlay(
                    Button(action: {
                        NotificationCenter.default.post(name: .shareLocal, object: nil, userInfo: ["index": UIState.activeCard])
//                        shareLocal(image: takeCapture())
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .frame(width: 48, height: 48)
                            .foregroundColor(.white)
                    }
                )
                .frame(width: 48, height: 48)
                .cornerRadius(10)
                .foregroundColor(Color.black)

            Button(action: {
                NotificationCenter.default.post(name: .shareInstagram, object: nil, userInfo: ["index": UIState.activeCard])
//                shareInstagram(image: takeCapture())
            }) {
                Image("instagram")
                    .frame(width: 48, height: 48)
                    .foregroundColor(.white)
            }
            .frame(width: 48, height: 48)
            .cornerRadius(10)
            // 트위터 사진 공유 지원 중단으로 인한 보류
//            Button(action: {}) {
//                Image("twitter")
//                    .resizable()
//                    .frame(width: 48, height: 48)
//                    .foregroundColor(.white)
//            }
//            .frame(width: 48, height: 48)
//            .cornerRadius(10)
        }
    }
}

// MARK: - ShareButtons_Previews

struct ShareButtons_Previews: PreviewProvider {
    static var previews: some View {
        ShareButtons()
    }
}

//
//  Outing.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/31.
//

import SwiftUI

// MARK: - BottomOuting

struct BottomOuting: View {
    // MARK: Internal

    var body: some View {
        VStack {
            Button(action: {
                count = 3
                flag = true
                challengeState.type = .running
            }, label: {
                GradientRoundedButton(
                    content: "귀가완료".localized,
                    startColor: Color.black,
                    endColor: Color.black,
                    width: 130,
                    height: 56,
                    cornerRadius: 16.0,
                    fontColor: Color.white
                )
            })
                .padding(.bottom, 40)

            GradientRoundedButton(content: """
            외출시간 동안은 나가도 기록이 유지됩니다.
            집에 돌아오면 귀가 버튼을 5초간 눌러주세요.
            """, startColor: Color.gray.opacity(0.5), endColor: Color.gray.opacity(0.5), width: 328, height: 60, cornerRadius: 16, fontColor: Color.white)
                .multilineTextAlignment(.center)
        }
    }

    // MARK: Private

    @EnvironmentObject private var challengeState: ChallengeState
    @Binding var count: Int
    @Binding var flag: Bool
}

// MARK: - BottomOuting_Previews

struct BottomOuting_Previews: PreviewProvider {
    static var previews: some View {
        BottomOuting(count: .constant(1), flag: .constant(false))
            .environmentObject(ChallengeState())
    }
}

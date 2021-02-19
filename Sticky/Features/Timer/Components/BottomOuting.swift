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
        VStack(spacing: 16) {
            Button(action: {
                count = 3
                flag = true
                challengeState.type = .running
            }, label: {
                GradientRoundedButton(
                    content: "집 도착 완료",
                    startColor: Color.black,
                    endColor: Color.black,
                    width: 280,
                    height: 60,
                    cornerRadius: 16,
                    fontColor: Color.white
                )
            })

            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color.white.opacity(0.3))
                .frame(width: 280, height: 72)
                .overlay(
                    Text("외출 시간 동안은 나가도 기록이 유지됩니다.\n집에 돌아오면 귀가 버튼을 5초간 눌러주세요.")
                        .kerning(-0.3)
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                )
        }
    }

    // MARK: Private

    @EnvironmentObject private var challengeState: ChallengeState
    @EnvironmentObject private var locationManager: LocationManager
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

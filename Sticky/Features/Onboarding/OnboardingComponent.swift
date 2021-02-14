//
//  Onboarding1.swift
//  Sticky
//
//  Created by 지현우 on 2021/02/14.
//

import SwiftUI

// MARK: - Onboarding1

struct Onboarding1: View {
    var body: some View {
        VStack {
            Image("onboarding_01")
                .padding(.bottom, 40)

            Text("집에 있는 시간을 기록하세요")
                .font(.custom("AppleSDGothicNeo-Bold", size: 17))
                .padding(.bottom, 4)

            Text("""
            챌린지는 집에서만 시작할 수 있어요.
            달성한 시간에 따라 레벨과 배지가 부여됩니다.
            """)
                .font(.custom("AppleSDGothicNeo", size: 14))
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Onboarding2

struct Onboarding2: View {
    var body: some View {
        VStack {
            Image("onboarding_02")
                .padding(.bottom, 40)

            Text("나의 기록을 공유하세요")
                .font(.custom("AppleSDGothicNeo-Bold", size: 17))
                .padding(.bottom, 4)

            Text("""
            끈기있게 보낸 집콕 시간과 달성 기록을
            SNS에 공유해서 친구들에게 자랑해보세요.
            """)
                .font(.custom("AppleSDGothicNeo", size: 14))
                .multilineTextAlignment(.center)
            
        }
    }
}

// MARK: - Onboarding3

struct Onboarding3: View {
    var body: some View {
        VStack {
            Image("onboarding_03")
                .padding(.bottom, 40)

            Text("잡깐 나갔다올 수 있어요")
                .font(.custom("AppleSDGothicNeo-Bold", size: 17))
                .padding(.bottom, 4)

            Text("""
            피치못할 사정이 있다면 하트를 사용해서 외출하세요.
            하트 1개당 20분, 챌린지마다 3개가 주어져요.
            """)
                .font(.custom("AppleSDGothicNeo", size: 14))
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Onboarding1_Previews

struct Onboarding1_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding1()
    }
}

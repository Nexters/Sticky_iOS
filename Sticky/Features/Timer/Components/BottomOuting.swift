//
//  Outing.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/31.
//

import SwiftUI

// MARK: - BottomOuting

struct BottomOuting: View {
    @EnvironmentObject var challengeState: ChallengeState
    @EnvironmentObject var locationManager: LocationManager
    @Binding var count: Int
    @Binding var flag: Bool

    @GestureState var isDetectingLongPress = false
    @State var completedLongPress = false

    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 5)
            .updating($isDetectingLongPress) { currentState, gestureState,
                transaction in
                gestureState = currentState
                transaction.animation = Animation.easeIn(duration: 4.0)
            }
            .onEnded { finished in
                self.completedLongPress = finished
                count = 3
                flag = true
                challengeState.type = .running
            }
    }

    var body: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(self.isDetectingLongPress ? .gray : .black)
                .frame(width: 280, height: 60)
                .gesture(longPress)
                .overlay(Text("집 도착 완료").foregroundColor(.white))

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
}

// MARK: - BottomOuting_Previews

struct BottomOuting_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Background.outing
                .ignoresSafeArea()
            BottomOuting(count: .constant(1), flag: .constant(false))
                .environmentObject(ChallengeState())
        }
    }
}

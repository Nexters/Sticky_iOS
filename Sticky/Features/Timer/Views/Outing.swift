//
//  Outing.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/31.
//

import SwiftUI

// MARK: - Outing

struct Outing: View {
    // MARK: Internal

    @Binding var timer: Timer?
    @EnvironmentObject var challengeState: ChallengeState
    @State var minute: Int = 30
    @State var second: Int = 0

    var body: some View {
        ZStack {
            Color.Palette.negative
                .ignoresSafeArea()
            VStack {
                ZStack {
                    Circle()
                        .foregroundColor(.pink)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                    VStack {
                        HStack {
                            Text("\(minute)")
                                .font(.custom("Modak", size: 80))
                                .foregroundColor(.white)
                                .bold()
                            VStack {
                                Circle().frame(width: 8, height: 8)
                                Circle().frame(width: 8, height: 8)
                            }.padding(.horizontal, 8)
                                .foregroundColor(.white)
                            Text("\(String(format: "%02d", self.second))")
                                .font(.custom("Modak", size: 80))
                                .foregroundColor(.white)
                                .bold()
                        }
                        Text("외출중")
                            .font(.custom("Modak", size: 20))
                            .foregroundColor(.white)
                            .bold()
                    }
                }

                BottomOuting()
                    .padding(.top, 56)
            }
            OutingCount(count: $countTime)
                .isHidden(!flag)
        }
        .onAppear {
            startTimer()
        }
    }

    // MARK: Private

    @State private var flag = true
    @State private var countTime = 3

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in

            if self.flag {
                // 애니메이션 진입
                self.countTime -= 1
                if self.countTime == 0 {
                    self.flag = false
                }
            } else {
                // 애니메이션 종료 후
                if self.second == 0 {
                    if self.minute == 0 {
                        // 외출하기 시간 지남
                        challengeState.type = .notRunning
                        timer.invalidate()
                        self.timer = nil
                    } else {
                        self.minute -= 1
                        self.second = 59
                    }
                } else {
                    self.second -= 1
                }
            }
        }
    }
}

// MARK: - Outing_Previews

struct Outing_Previews: PreviewProvider {
    static var previews: some View {
        Outing(timer: .constant(Timer()))
            .environmentObject(ChallengeState())
    }
}

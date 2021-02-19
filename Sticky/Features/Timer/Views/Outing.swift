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
    
    @Binding var flag: Bool
    @Binding var countTime: Int
    @State var outingTimer: Timer?
    @EnvironmentObject var challengeState: ChallengeState
    @State var isAnimated = false
    var body: some View {
        ZStack {
            Color.Background.outing
                .ignoresSafeArea()
            VStack {
                ZStack {
                    Circle()
                        .foregroundColor(Color.Background.outingAnimation)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                        .scaleEffect(isAnimated ? 3 : 0.5)
                        .animation(circleAnimation)
                    
                    VStack {
                        Text("외출중")
                            .font(.custom("AppleSDGothicNeo", size: 17))
                            .foregroundColor(.white)
                            .bold()
                        HStack {
                            Text("\(challengeState.outingTimeDate.minute)")
                                .font(.custom("Modak", size: 96))
                                .foregroundColor(.white)
                                .bold()
                            VStack {
                                Circle().frame(width: 8, height: 8)
                                Circle().frame(width: 8, height: 8)
                            }.padding(.horizontal, 8)
                                .foregroundColor(.white)
                            Text("\(String(format: "%02d", challengeState.outingTimeDate.second))")
                                .font(.custom("Modak", size: 80))
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }
                
                BottomOuting(count: $countTime, flag: $flag)
                    .padding(.top, 56)
            }
            OutingCount(count: $countTime)
                .isHidden(!flag)
        }
        .onAppear{
            self.isAnimated = true
        }
        .onDisappear{
            self.isAnimated = false
        }
    }

    // MARK: Private
    private var circleAnimation: Animation{
        Animation.linear(duration: 1.0).repeatForever(autoreverses: false)
    }

}

// MARK: - Outing_Previews

struct Outing_Previews: PreviewProvider {
    static var previews: some View {
        Outing(timer: .constant(Timer()), flag: .constant(false), countTime: .constant(3))
            .environmentObject(ChallengeState())
    }
}

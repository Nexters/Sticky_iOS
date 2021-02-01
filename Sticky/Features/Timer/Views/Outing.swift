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
                            Text("22")
                                .font(.custom("Modak", size: 80))
                                .foregroundColor(.white)
                                .bold()
                            VStack {
                                Circle().frame(width: 8, height: 8)
                                Circle().frame(width: 8, height: 8)
                            }.padding(.horizontal, 8)
                                .foregroundColor(.white)
                            Text("11")
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

            self.countTime -= 1
            if self.countTime == 0 {
                timer.invalidate()
                self.timer = nil
                self.flag = false
                print("nil")
            }
        }
    }
}

// MARK: - Outing_Previews

struct Outing_Previews: PreviewProvider {
    static var previews: some View {
        Outing(timer: .constant(Timer()))
    }
}

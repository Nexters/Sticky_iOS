//
//  LevelView.swift
//  Sticky
//
//  Created by deo on 2021/02/01.
//

import SwiftUI

// MARK: - LevelView

struct LevelView: View {
    // MARK: Internal

    var level: Int
    var grade: String
    var total_time: TimeData

    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .frame(width: 264, height: 364)
            .foregroundColor(.white)
            .overlay(
                VStack {
                    Image("blue_sticky")
                        .resizable()
                        .frame(width: 160, height: 160)
                        .padding(.top, 28)
                    Text("Lv\(level) \(grade)")
                        .font(.custom("Modak", size: 28))
                    Text("총 누적시간은\n\(dateString(time: total_time))입니다.")
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                        .frame(width: 224)
                    Spacer()
                    Text("sticky")
                        .font(.custom("Modak", size: 16))
                        .foregroundColor(.gray)
                        .opacity(2.0)
                        .padding(.bottom, 20)
//                    Image("logo")
//                        .resizable()
//                        .opacity(2.0)
//                        .frame(width: 52, height: 16)
//                        .padding(.bottom, 20)
                }
            )
    }

    // MARK: Private

    private func dateString(time: TimeData) -> String {
        var result = ""
        if time.day != 0 {
            result += "\(time.day)일"
        }
        if time.hour != 0 {
            result += " \(time.hour)시간"
        }
        if time.minute != 0 {
            result += " \(time.minute)분"
        }
        return result
    }
}

// MARK: - LevelView_Previews

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Sticky.blue_bg.ignoresSafeArea()
            LevelView(level: 3, grade: "Yellow Sticky", total_time: TimeData(day: 4, hour: 20))
        }
    }
}

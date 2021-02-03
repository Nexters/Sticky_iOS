//
//  Summary.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import SwiftUI

// MARK: - Summary

struct Summary: View {
    // MARK: Internal

    /// 누적 시간
    var seconds: Int

    var body: some View {
        let tier = Tier.of(hours: seconds / 3600)
        let timeString = secondsToDaysHoursMinutes(seconds: seconds)
        VStack(alignment: .trailing) {
            Text("등급정보")
                .underline()
                .foregroundColor(.gray)
            HStack(alignment: .top) {
                Spacer()
                VStack {
                    Image("level\(tier.level)")
                        .frame(width: 140, height: 140)
                        .padding(.bottom, 16)
                    // 레벨 변환
                    HStack {
                        Text("Lv\(tier.level)")
                            .foregroundColor(Color(tier.color()))
                            .font(.system(size: 24))
                            .bold()
                        Text("\(tier.name()) \(tier.level)")
                            .font(.system(size: 24))
                            .bold()
                    }
                    .padding(.bottom, 8)

                    // 현재 누적 시간
                    Text("\(timeString)")
                        .font(.system(size: 20))

                    // 다음 레벨 계산
                    if tier.level < 10 {
                        Text("다음 레벨까지 \(tier.next() - seconds / 3600)시간 남았습니다")
                            .foregroundColor(Color.GrayScale._600)
                    }
                }
                Spacer()
            }
        }
    }

    // MARK: Private

    private func secondsToDaysHoursMinutes(seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko")
        formatter.calendar = calendar
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .full
        return formatter.string(from: TimeInterval(seconds))!
    }
}

// MARK: - Summary_Previews

struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.GrayScale._100.ignoresSafeArea()
            Summary(seconds: 10)
                .border(Color.black)
        }
    }
}

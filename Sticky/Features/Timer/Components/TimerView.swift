//
//  TimerView.swift
//  Sticky
//
//  Created by deo on 2021/01/30.
//

import SwiftUI

// MARK: - TimerView

struct TimerView: View {
//    @Binding var time: TimeData
    @Binding var seconds: Int

    var body: some View {
        let time = seconds.toTimeData()
        VStack {
            Text("\(time.day) day")
                .font(.custom("Modak", size: 40))

            HStack {
                Text(String(format: "%02d", time.hour))
                    .font(.custom("Modak", size: 96))
                    .bold()
                VStack {
                    Circle().frame(width: 8, height: 8)
                    Circle().frame(width: 8, height: 8)
                }.padding(.horizontal, 8)
                Text(String(format: "%02d", time.minute))
                    .font(.custom("Modak", size: 96))
                    .bold()
            }
            .frame(height: 80)
            .padding(.vertical, 6)

            Text(String(format: "%02d", time.second))
                .font(.custom("Modak", size: 40))
        }
    }
}

// MARK: - TimerView_Previews

struct TimerView_Previews: PreviewProvider {
    struct TimerViewWrapper: View {
        @State var time = 0

        var body: some View {
            TimerView(seconds: $time)
        }
    }

    static var previews: some View {
        TimerViewWrapper()
    }
}

//
//  TimerView.swift
//  Sticky
//
//  Created by deo on 2021/01/30.
//

import SwiftUI

// MARK: - TimerView

struct TimerView: View {
    @Binding var time: TimeData

    var body: some View {
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
            .padding(.vertical, 16)

            Text(String(format: "%02d", time.second))
                .font(.custom("Modak", size: 40))
        }
    }
}

// MARK: - TimerView_Previews

struct TimerView_Previews: PreviewProvider {
    struct TimerViewWrapper: View {
        @State var time = TimeData()

        var body: some View {
            TimerView(time: $time)
        }
    }

    static var previews: some View {
        TimerViewWrapper()
    }
}

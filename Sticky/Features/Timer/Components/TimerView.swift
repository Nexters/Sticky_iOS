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
            Text("\(time.day)일")
                .font(.system(size: 40))
                .foregroundColor(.white)

            Text(String(format: "%02d:%02d", time.hour, time.minute))
                .font(.system(size: 80))
                .bold()
                .foregroundColor(.white)

            Text(String(format: "%02d", time.second))
                .font(.system(size: 30))
                .foregroundColor(.white)
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

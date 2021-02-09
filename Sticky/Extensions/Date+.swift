//
//  Date+.swift
//  Sticky
//
//  Created by 지현우 on 2021/02/09.
//

import Foundation

extension Date {
    func compareTo(date: Date) -> DateComponents {
        var calendar = Calendar.current
        if let timeZone = TimeZone(identifier: "UTC") {
            calendar.timeZone = timeZone
        }

        let componenets = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: self)

        return componenets
    }
}

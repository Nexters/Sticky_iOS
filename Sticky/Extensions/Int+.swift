//
//  Int+.swift
//  Sticky
//
//  Created by deo on 2021/02/05.
//

import Foundation

extension Int {
    // seconds로 판단하여 Days, Hours, Minutes로 변환해줌
    func ToDaysHoursMinutes(
        allowedUnits: NSCalendar.Unit = [.day, .hour, .minute],
        unitStyle: DateComponentsFormatter.UnitsStyle = .full
    ) -> String {
        let formatter = DateComponentsFormatter()
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko")
        formatter.calendar = calendar
        formatter.unitsStyle = unitStyle
        formatter.allowedUnits = allowedUnits
        return formatter.string(from: TimeInterval(self))!
    }
}

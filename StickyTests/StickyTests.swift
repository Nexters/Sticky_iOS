//
//  StickyTests.swift
//  StickyTests
//
//  Created by deo on 2021/01/13.
//

@testable import Sticky
import XCTest

class StickyTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testTierOfHours() throws {
        let hours = 100
        let tier = Tier.of(hours: hours)
        print(tier)
        assert(tier.level == 6)
    }

    func testSecondsToTimeString() throws {
        let seconds = 90440
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko")
        let formatter = DateComponentsFormatter()
        formatter.calendar = calendar
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = .full

        let formattedString = formatter.string(from: TimeInterval(seconds))!
        print(formattedString)
    }

    func testBadgeMock() throws {
        let badges = Array(1 ... 99).map { num in
            Badge(badgeType: BadgeType.monthly, badgeValue: "10", name: "Badge Name \(num)", updated: Date(), count: 0)
        }
        print(badges)
        assert(badges.count == 99)
    }

    func testPerformanceExample() throws {
        self.measure {}
    }
}

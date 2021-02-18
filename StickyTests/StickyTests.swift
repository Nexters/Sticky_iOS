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

    func testNextBadge() throws {
        let nextMonthlyBadge = nextBadge(
            badgeType: BadgeType.monthly,
            badges: monthly_default
        )
        print(nextMonthlyBadge)
        let nextContiousBadge = nextBadge(
            badgeType: BadgeType.continuous,
            badges: continuous_default
        )
        print(nextContiousBadge)
    }

    func testPerformanceExample() throws {
        self.measure {}
    }
}

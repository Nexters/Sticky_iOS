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
        assert(tier.major == 2 && tier.minor == 2)
    }

    func testBadgeMock() throws {
        let badges = Array(1 ... 99).map { num in
            Badge(badgeType: BadgeType.accumulation, name: "Badge Name \(num)", updated: Date(), count: 0)
        }
        print(badges)
        assert(badges.count == 99)
    }

    func testPerformanceExample() throws {
        measure {}
    }
}

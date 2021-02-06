//
//  ShareState.swift
//  Sticky
//
//  Created by deo on 2021/02/01.
//

import Foundation

// MARK: - ShareType

/** 공유 유형
 - slide: 슬라이드
 - level: 레벨
 - monthly: 월간
 - continuously: 연속
 - level_up: 레벨업
 */
enum ShareType: String {
    case slide
    case card
}

// MARK: - ShareViewModel

class ShareViewModel: ObservableObject {
    // MARK: Lifecycle

    init() {
        badge = Badge(badgeType: BadgeType.monthly, badgeValue: "10", name: "")
        seconds = 0
    }

    // MARK: Internal

    @Published var badge: Badge
    @Published var seconds: Int
}

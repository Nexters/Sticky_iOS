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
        badge = loadBadge(forKey: "shareBadge")
        seconds = 0
    }

    // MARK: Internal

    @Published var seconds: Int

    @Published var badge: Badge {
        didSet {
            let data = try? encoder.encode(badge)
            UserDefaults.standard.set(data, forKey: "shareBadge")
        }
    }
}

//
//  Badge.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import Foundation

// MARK: - Badge

/**
 뱃지
 - badgeType: 유형
 - name: 명칭
 - updated: 갱신일자
 - count: 획득 횟수
 - active: 활성여부
 */
struct Badge: Hashable, Identifiable {
    var id = UUID()
    var badgeType: BadgeType
    var badgeValue: Int
    var name: String
    var updated: Date
    var count: Int = 0
    var active: Bool = false

    var image: String {
        "\(badgeType)_\(badgeValue)\(active ? "" : "_locked")"
    }
}

/// 다국어 지원 시 locale 변경필요
extension Date {
    func toString(withFormat format: String = "YYYY.MM.dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

// MARK: - BadgeType

/**
 Badge 유형
 - accumulate: 누적
 - continuous: 연속
 - special: 스페셜
 */
enum BadgeType: String {
    /// 누적
    case monthly
    case continuous
    case special
}

/// Mock 데이터
func badgeMocks(count: Int) -> [Badge] {
    return Array(1 ... count).map { _ in
        Badge(badgeType: BadgeType.monthly, badgeValue: 10, name: "Badge Name", updated: Date(), count: 0)
    }
}

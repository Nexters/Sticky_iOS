//
//  Badge.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import Foundation
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
    var name: String
    var updated: Date
    var count: Int = 0
    var active: Bool = false
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

/**
 Badge 유형
 - accumulate: 누적
 - continuous: 연속
 - special: 스페셜
 */
enum BadgeType: Int {
    /// 누적
    case accumulation = 1
    case continuous
    case special
}

/// Mock 데이터
let badgeMocks = Array(1 ... 9).map { _ in
    Badge(badgeType: BadgeType.accumulation, name: "Badge Name", updated: Date(), count: 0)
}

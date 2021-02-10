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
    var badgeValue: String
    var _name: String = ""
    var updated: Date?
    var count: Int = 0

    var active: Bool {
        count > 0 || updated != nil
    }

    var image: String {
        switch badgeType {
        case .continuous,
             .monthly,
             .special:
            return "\(badgeType)_\(badgeValue)\(active ? "" : "_locked")"
        case .level:
            return "level\(badgeValue)"
        }
    }

    var name: String {
        set(name) {
            _name = name
        }
        get {
            // continuous의 0.5 경우에만 12hours
            switch badgeType {
            case .continuous,
                 .monthly,
                 .special:
                if badgeType == BadgeType.continuous, badgeValue == "0.5" {
                    return "12 Hours"
                } else {
                    return "\(badgeValue) \(badgeType.unit)"
                }
            case .level:
                return _name
            }
        }
    }

    var description: String {
        switch badgeType {
        case .monthly:
            return "한달동안 집에서 보낸 시간\n\(badgeValue)을 달성하면 받을 수 있습니다."
        case .continuous:
            return "이번 챌린지에서 집에서 보낸 시간\n\(badgeValue)을 달성하면 받을 수 있습니다."
        case .level,
             .special:
            return "준비 중입니다."
        }
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
 - level: 레벨
 */
enum BadgeType: String {
    case special
    case monthly
    case continuous
    case level
}

extension BadgeType {
    func toString(value: String) -> String {
        switch self {
        case .special:
            return "특별한 배지"
        case .monthly:
            return "한달 동안 집에서 보낸 시간\n\(value)을 달성했습니다!"
        case .continuous:
            return "연속으로 집에서 보낸 시간\n\(value)을 달성했습니다!"
        case .level:
            return "총 누적시간은\n\(value)입니다."
        }
    }

    var unit: String {
        switch self {
        case BadgeType.special:
            return ""
        case BadgeType.monthly:
            return "Hours"
        case BadgeType.continuous:
            return "Days"
        case BadgeType.level:
            return ""
        }
    }
}

// MARK: - Special

enum Special: String {
    case first
}

func makeBadges(badgeType: BadgeType, dict: [String: CountAndUpdated]) -> [Badge] {
    return dict.sorted { Double($0.0)! < Double($1.0)! }.map { key, value in
        Badge(
            badgeType: badgeType,
            badgeValue: key,
            updated: value.date,
            count: value.count
        )
    }
}

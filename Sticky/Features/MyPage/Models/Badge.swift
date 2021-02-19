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
class Badge: Codable, Hashable, Identifiable {
    // MARK: Lifecycle

    init(
        badgeType: BadgeType,
        badgeValue: String,
        _name: String = "",
        updated: Date? = nil,
        count: Int = 0
    ) {
        self.badgeType = badgeType
        self.badgeValue = badgeValue
        self._name = _name
        self.updated = updated
        self.count = count
    }

    // MARK: Public

    public var updated: Date?
    public var count: Int = 0

    // MARK: Internal

    var id = UUID()
    var badgeType: BadgeType
    var badgeValue: String
    var _name: String = ""

    // 업데이트 일자가 이번 달에만 활성화
    var active: Bool {
        guard let date = updated else { return false }
        switch badgeType {
        case .monthly:
            return isItThisMonth(date: date)
        case .continuous,
             .level,
             .special:
            // 한 번이라도 획득했으면 무조건 활성화
            return count > 0
        case .unknown:
            return false
        }
    }

    var image: String {
        switch badgeType {
        case .special:
            return active ? "\(badgeType)_\(badgeValue)" : "special_locked"
        case .continuous,
             .monthly:
            return "\(badgeType)_\(badgeValue)\(active ? "" : "_locked")"
        case .level:
            return "level\(badgeValue)"
        case .unknown:
            return ""
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
                 .special,
                 .unknown:
                if badgeType == BadgeType.continuous, badgeValue == "0.5" {
                    return "12 Hours"
                }
                return "\(badgeValue) \(badgeType.unit)"
            case .level:
                return _name
            }
        }
    }

    var description: String {
        switch badgeType {
        case .monthly:
            return "한 달동안 집에서 보낸 시간\n\(name)을 달성하면 받을 수 있습니다."
        case .continuous:
            return "이번 챌린지에서 집에서 보낸 시간\n\(name)을 달성하면 받을 수 있습니다."
        case .level,
             .special,
             .unknown:
            return ""
        }
    }

    static func == (lhs: Badge, rhs: Badge) -> Bool {
        return lhs.badgeType == rhs.badgeType
            && lhs.badgeValue == rhs.badgeValue
            && lhs._name == rhs._name
            && lhs.updated == rhs.updated
            && lhs.count == rhs.count
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(badgeType)
        hasher.combine(badgeValue)
        hasher.combine(_name)
        hasher.combine(updated)
        hasher.combine(count)
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
enum BadgeType: String, Codable {
    case unknown
    case special
    case monthly
    case continuous
    case level
}

extension BadgeType {
    func toString(value: String) -> String {
        switch self {
        case .unknown:
            return ""
        case .special:
            if value.trimmingCharacters(in: .whitespaces) == "welcome" {
                return "스티키에 오신걸 환영합니다!"
            }
            return value
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
        case .level,
             .special,
             .unknown:
            return ""
        case .monthly:
            return "Hours"
        case .continuous:
            return "Days"
        }
    }

    var alias: String {
        switch self {
        case .unknown:
            return ""
        case .continuous:
            return "연속 달성 기록"
        case .monthly:
            return "월간 달성 기록"
        case .special:
            return "스페셜 기록"
        case .level:
            return "레벨"
        }
    }
}

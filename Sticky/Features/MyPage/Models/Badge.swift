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
        Badge(badgeType: BadgeType.monthly, badgeValue: "10", name: "Badge Name", updated: Date(), count: 0)
    }
}

let monthlyBadges = [
    "10", "30", "50",
    "100", "150", "300",
    "500", "700", "720",
].map { hour in
    Badge(badgeType: BadgeType.monthly,
          badgeValue: hour,
          name: "\(Int(hour)!) Hours",
          updated: Date(),
          count: 0)
}

var monthlyBadgesDict = monthlyBadges.toDictionary { $0.badgeValue }

let continuousBadges = [
    "0.5", "1", "3", "7",
    "10", "15", "30",
].map { day in
    Badge(badgeType: BadgeType.continuous,
          badgeValue: day,
          name: day != "0.5" ? "\(Int(day)!) Days" : "12 Hours",
          updated: Date(),
          count: 0)
}

var continuousBadgesDict = continuousBadges.toDictionary { $0.badgeValue }

// MARK: - Special

enum Special {
    case first
}

// MARK: - BadgeViewModel

typealias CountAndDate = (Int, Date?)

// MARK: - BadgeViewModel

class BadgeViewModel: ObservableObject {
    // MARK: Lifecycle

    init() {
        self.specials = UserDefaults.standard.object(forKey: "specials") as? [Special: CountAndDate] ?? [:]
        self.monthly = UserDefaults.standard.object(forKey: "monthly") as? [String: CountAndDate] ?? [
            "10": (0, nil), "30": (0, nil), "50": (0, nil),
            "100": (0, nil), "150": (0, nil), "300": (0, nil),
            "500": (0, nil), "700": (0, nil), "720": (0, nil),
        ]
        self.continuous = UserDefaults.standard.object(forKey: "continuous") as? [String: CountAndDate] ?? [
            "0.5": (0, nil), "1": (0, nil), "3": (0, nil), "7": (0, nil),
            "10": (0, nil), "15": (0, nil), "30": (0, nil),
        ]
    }

    // MARK: Internal

    @Published var specials: [Special: CountAndDate] {
        didSet {
            UserDefaults.standard.set(specials, forKey: "specials")
        }
    }

    @Published var monthly: [String: CountAndDate] {
        didSet {
            UserDefaults.standard.set(monthly, forKey: "monthly")
        }
    }

    @Published var continuous: [String: CountAndDate] {
        didSet {
            UserDefaults.standard.set(continuous, forKey: "continuous")
        }
    }
}

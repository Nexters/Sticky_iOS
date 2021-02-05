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
    var updated: Date?
    var count: Int = 0

    var active: Bool {
        count > 0 || updated != nil
    }

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
    case special
    case monthly
    case continuous
}

extension BadgeType {
    func format(value: String) -> String {
        switch self {
        case .special:
            return "특별한 배지"
        case .monthly:
            return "한달 동안 집에서 보낸 시간\n\(value)을 달성했습니다!"
        case .continuous:
            return "연속으로 집에서 보낸 시간\n\(value)을 달성했습니다!"
        }
    }
}

/// Mock 데이터
func badgeMocks(count: Int) -> [Badge] {
    return Array(1 ... count).map { _ in
        Badge(badgeType: BadgeType.monthly, badgeValue: "10", name: "Badge Name", updated: Date(), count: 0)
    }
}

func makeBadges(badgeType: BadgeType, dict: [String: CountAndDate]) -> [Badge] {
    var unit: String {
        switch badgeType {
        case BadgeType.special:
            return ""
        case BadgeType.monthly:
            return "Hours"
        case BadgeType.continuous:
            return "Days"
        }
    }
    return dict.sorted { Double($0.0)! < Double($1.0)! }.map { key, value in
        Badge(
            badgeType: badgeType,
            badgeValue: key,
            name: key == "0.5" ? "12 Hours" : "\(key) \(unit)",
            updated: value.date,
            count: value.count
        )
    }
}

// MARK: - Special

enum Special: String {
    case first
}

// MARK: - BadgeViewModel

typealias CountAndDate = (count: Int, date: Date?)

// MARK: - BadgeViewModel

class BadgeViewModel: ObservableObject {
    // MARK: Lifecycle

    init() {
        self.specials = UserDefaults.standard.object(forKey: "specials") as? [String: CountAndDate] ?? [
            Special.first.rawValue: (0, nil),
        ]
        self.monthly = UserDefaults.standard.object(forKey: "monthly") as? [String: CountAndDate] ?? [
            "10": (1, Date()), "30": (0, nil), "50": (0, nil),
            "100": (0, nil), "150": (0, nil), "300": (0, nil),
            "500": (0, nil), "700": (0, nil), "720": (0, nil),
        ]
        self.continuous = UserDefaults.standard.object(forKey: "continuous") as? [String: CountAndDate] ?? [
            "0.5": (0, nil), "1": (0, nil), "3": (0, nil), "7": (0, nil),
            "10": (0, nil), "15": (0, nil), "30": (0, nil),
        ]
    }

    // MARK: Internal

    @Published var specials: [String: CountAndDate] {
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

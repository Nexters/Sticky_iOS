//
//  BadgeViewModel.swift
//  Sticky
//
//  Created by deo on 2021/02/06.
//

import Foundation

// MARK: - BadgeInfo

// typealias BadgeInfo = [String: CountAndUpdated]

struct BadgeInfo: Codable {
    var items: [String: CountAndUpdated]
}

// MARK: - CountAndUpdated

struct CountAndUpdated: Codable {
    var count: Int = 0
    var date: Date? = nil
}

let special_default = BadgeInfo(items: [Special.first.rawValue: CountAndUpdated()])

let monthly_default = BadgeInfo(items: [
    "10": CountAndUpdated(), "30": CountAndUpdated(), "50": CountAndUpdated(),
    "100": CountAndUpdated(), "150": CountAndUpdated(), "300": CountAndUpdated(),
    "500": CountAndUpdated(), "700": CountAndUpdated(), "720": CountAndUpdated(),
])
/// 챌린지당 몇시간을 유지했는지
let continuous_default = BadgeInfo(items: [
    "0.5": CountAndUpdated(), "1": CountAndUpdated(), "3": CountAndUpdated(), "7": CountAndUpdated(),
    "10": CountAndUpdated(), "15": CountAndUpdated(), "30": CountAndUpdated(),
])

// MARK: - BadgeViewModel

class BadgeViewModel: ObservableObject {
    // MARK: Lifecycle

    init() {
        self.select = Badge(badgeType: BadgeType.monthly, badgeValue: "10", _name: "")
        self.badgeQueue = getBadgeQueue(forKey: "badgeQueue")
        /// 스페셜 배지
        self.specials = getBadgeInfo(
            forKey: "specials",
            default_: special_default
        )
        /// 전체 획득한 월간 배지
        self.previous_monthly = getBadgeInfo(
            forKey: "previous_monthly",
            default_: monthly_default
        )
        /// 이번 달에 획득한 배지리스트
        print("BadgeViewModel - monthly: \(getBadgeInfo(forKey: "monthly"))")
        self.monthly = getBadgeInfo(
            forKey: "monthly",
            default_: monthly_default
        )

        /// 전체 획득한 연속 배지
        self.previous_continuous = getBadgeInfo(
            forKey: "previous_continuous",
            default_: continuous_default
        )
        /// 현재 챌린지의 누적
        print("BadgeViewModel - continuous: \(getBadgeInfo(forKey: "continuous"))")
        self.continuous = getBadgeInfo(
            forKey: "continuous",
            default_: continuous_default
        )
    }

    // MARK: Internal

    @Published var select: Badge

    // 획득한 배지 처리를 위한 queue
    @Published var badgeQueue: [Badge] {
        didSet {
            let data = try? encoder.encode(badgeQueue)
            UserDefaults.standard.set(data, forKey: "badgeQueue")
        }
    }

    @Published var specials: BadgeInfo {
        didSet {
            print("specials set: \(specials)")
            let data = try? encoder.encode(specials.items)
            UserDefaults.standard.set(data, forKey: "specials")
        }
    }

    @Published var previous_monthly: BadgeInfo {
        didSet {
            print("previous_monthly set: \(previous_monthly)")
            let data = try? encoder.encode(previous_monthly.items)
            UserDefaults.standard.set(data, forKey: "previous_monthly")
        }
    }

    @Published var monthly: BadgeInfo {
        didSet {
            print("monthly set: \(monthly)")
            let data = try? encoder.encode(monthly.items)
            UserDefaults.standard.set(data, forKey: "monthly")
        }
    }

    @Published var continuous: BadgeInfo {
        didSet {
            print("continuous set: \(continuous)")
            let data = try? encoder.encode(continuous.items)
            UserDefaults.standard.set(data, forKey: "continuous")
        }
    }

    @Published var previous_continuous: BadgeInfo {
        didSet {
            print("previous_continuous set: \(continuous)")
            let data = try? encoder.encode(previous_continuous.items)
            UserDefaults.standard.set(data, forKey: "previous_continuous")
        }
    }
}

let encoder = PropertyListEncoder()
let decoder = PropertyListDecoder()
private func getBadgeInfo(
    forKey: String,
    default_: BadgeInfo = BadgeInfo(items: [:])
) -> BadgeInfo {
    if let data = UserDefaults.standard.value(forKey: forKey) as? Data {
        do {
            let items = try decoder.decode([String: CountAndUpdated].self, from: data)
            return BadgeInfo(items: items)
        } catch {
            print(error.localizedDescription)
            return default_
        }
    }
    return default_
}

private func getBadgeQueue(
    forKey: String,
    default_: [Badge] = []
) -> [Badge] {
    if let data = UserDefaults.standard.value(forKey: forKey) as? Data {
        do {
            let badges = try decoder.decode([Badge].self, from: data)
            return badges
        } catch {
            print(error.localizedDescription)
            return default_
        }
    }
    return default_
}

/// 다음 획득할 월간 배지
func nextBadge(
    badgeType: BadgeType,
    badges: [String: CountAndUpdated]
) -> Badge {
    /// 월간은 무조건 1회인데, 연속은 1회가 아님
    let next = badges
        .filter { _, countAndDate in countAndDate.count == 0 }
        .sorted { Double($0.0)! < Double($1.0)! }
        .first
    let badgeValue = next?.key ?? ""

    return Badge(
        badgeType: badgeType,
        badgeValue: badgeValue,
        updated: nil
    )
}

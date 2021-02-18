//
//  BadgeViewModel.swift
//  Sticky
//
//  Created by deo on 2021/02/06.
//

import Foundation

let special_default = ["welcome", "locked", "locked"].map { keyword in
    Badge(badgeType: .special, badgeValue: keyword)
}

let monthly_default = ["10", "30", "50", "100", "150", "300", "500", "700", "720"].map { hours in
    Badge(badgeType: .monthly, badgeValue: hours)
}

let continuous_default = ["0.5", "1", "3", "7", "10", "15", "30"].map { days in
    Badge(badgeType: .continuous, badgeValue: days)
}

let encoder = PropertyListEncoder()
let decoder = PropertyListDecoder()
private func loadBadges(
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

// MARK: - BadgeViewModel

class BadgeViewModel: ObservableObject {
    // MARK: Lifecycle

    init() {
        self.select = Badge(badgeType: BadgeType.monthly, badgeValue: "10", _name: "")
        self.badgeQueue = getBadgeQueue(forKey: "badgeQueue")

        /// 스페셜 배지
        print("BadgeViewModel - specials: \(loadBadges(forKey: "specials"))")
        self.specials = loadBadges(
            forKey: "specials",
            default_: special_default
        )

        self.showCountBadge = false
        /// 이번 달에 획득한 배지리스트
        print("BadgeViewModel - monthly: \(loadBadges(forKey: "monthly"))")
        self.monthly = loadBadges(
            forKey: "monthly",
            default_: monthly_default
        )
        /// 현재 챌린지의 누적
        print("BadgeViewModel - continuous: \(loadBadges(forKey: "continuous"))")
        self.continuous = loadBadges(
            forKey: "continuous",
            default_: continuous_default
        )
    }

    // MARK: Internal

    @Published var select: Badge

    @Published var showCountBadge: Bool

    // 획득한 배지 처리를 위한 queue
    @Published var badgeQueue: [Badge] {
        didSet {
            let data = try? encoder.encode(badgeQueue)
            UserDefaults.standard.set(data, forKey: "badgeQueue")
        }
    }

    @Published var specials: [Badge] {
        didSet {
            print("specials set: \(specials)")
            let data = try? encoder.encode(specials)
            UserDefaults.standard.set(data, forKey: "specials")
        }
    }

    @Published var monthly: [Badge] {
        didSet {
            print("monthly set: \(monthly)")
            let data = try? encoder.encode(monthly)
            UserDefaults.standard.set(data, forKey: "monthly")
        }
    }

    @Published var continuous: [Badge] {
        didSet {
            print("continuous set: \(continuous)")
            let data = try? encoder.encode(continuous)
            UserDefaults.standard.set(data, forKey: "continuous")
        }
    }
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

/// 다음 획득할 배지
func nextBadge(
    badgeType: BadgeType,
    badges: [Badge]
) -> Badge {
    return badges
        .filter { badge in !badge.active }
        .sorted { Double($0.badgeValue)! < Double($1.badgeValue)! }
        .first ?? Badge(badgeType: .special, badgeValue: "locked")
}

/// 이번달 여부 확인
func isItThisMonth(date: Date) -> Bool {
    let calendar = Calendar(identifier: .gregorian)
    let component = calendar.dateComponents([.year, .month], from: Date())
    let thisYear = component.year
    let thisMonth = component.month
    let _component = calendar.dateComponents([.year, .month], from: date)
    return thisYear == _component.year && thisMonth == _component.month
}

/// welcome 배지 획득 여부 확인
func getWelcomeBadge(
    badges: [Badge]
) -> Badge? {
    return badges.filter { $0.badgeValue == "welcome" }.first
}

/// active 배지 카운트
func countActiveBadges(badges: [Badge]) -> Int {
    return badges.filter { badge in badge.active }.count
}

/// 가장 최근에 획득한 배지
func latestBadge(badges: [Badge]) -> Badge? {
    return badges.filter { badge in badge.active }.max(by: {
        $0.updated!.timeIntervalSinceReferenceDate < $1.updated!.timeIntervalSinceReferenceDate
    })
}

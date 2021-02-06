//
//  BadgeViewModel.swift
//  Sticky
//
//  Created by deo on 2021/02/06.
//

import Foundation

typealias CountAndDate = (count: Int, date: Date?)

// MARK: - BadgeViewModel

class BadgeViewModel: ObservableObject {
    // MARK: Lifecycle

    init() {
        self.specials = UserDefaults.standard.object(forKey: "specials") as? [String: CountAndDate] ?? [
            Special.first.rawValue: (0, nil),
        ]
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

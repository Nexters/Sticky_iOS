//
//  ShareViewModel.swift
//  Sticky
//
//  Created by deo on 2021/02/19.
//

import Foundation

class ShareViewModel: ObservableObject {
    // MARK: Lifecycle

    init() {
        badge = loadBadge(forKey: "shareBadge")
        seconds = UserDefaults.standard.integer(forKey: "shareSeconds")
//        let type = Main.ChallengeType(
//            rawValue: UserDefaults.standard.integer(forKey: "challengeType")
//        ) ?? .notRunning
//        switch type {
//        case .notAtHome,
//             .notRunning,
//             .outing:
//            seconds = 0
//        case .running:
//            seconds = UserDefaults.standard.integer(forKey: "shareSeconds")
//        }
    }

    // MARK: Internal

    @Published var seconds: Int {
        didSet {
            UserDefaults.standard.set(seconds, forKey: "shareSeconds")
        }
    }

    @Published var badge: Badge {
        didSet {
            let data = try? encoder.encode(badge)
            UserDefaults.standard.set(data, forKey: "shareBadge")
        }
    }
}

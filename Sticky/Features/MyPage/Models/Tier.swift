//
//  Tier.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import Foundation

// MARK: - Tier

struct Tier {
    let level: Int
}

extension Tier {
    /** 누적 시간을 Tier로 변환
     - 1: 0~10
     - 2: 11~20
     - 3: 21~30
     - 4: 31~60
     - 5: 61~90
     - 6: 91~120
     - 7: 121~200
     - 8: 201~280
     - 9: 281~360
     - 10: 361~
     */
    static func of(hours: Int) -> Tier {
        print("Tier - of(hours: ) -> hours: \(hours)")
        switch hours {
        case 0..<11:
            return Tier(level: 1)
        case 11..<21:
            return Tier(level: 2)
        case 21..<31:
            return Tier(level: 3)
        case 31..<61:
            return Tier(level: 4)
        case 61..<91:
            return Tier(level: 5)
        case 91..<121:
            return Tier(level: 6)
        case 121..<201:
            return Tier(level: 7)
        case 201..<281:
            return Tier(level: 8)
        case 281..<361:
            return Tier(level: 9)
        default:
            return Tier(level: 10)
        }
    }

    /** 다음 티어의 최소 시간
     */
    func next() -> Int {
        switch level {
        case 1:
            return 11
        case 2:
            return 21
        case 3:
            return 31
        case 4:
            return 61
        case 5:
            return 91
        case 6:
            return 121
        case 7:
            return 201
        case 8:
            return 281
        case 9:
            return 361
        default:
            return 0
        }
    }

    func name() -> String {
        switch level {
        case 1...3:
            return "Blue Sticky"
        case 4...6:
            return "Yellow Sticky"
        case 7...9:
            return "Green Sticky"
        case 10:
            return "Red Sticky"
        default:
            return "Unknown Sticky"
        }
    }

    func color() -> String {
        switch level {
        case 1...3:
            return "sticky-blue"
        case 4...6:
            return "sticky-yellow"
        case 7...9:
            return "sticky-green"
        case 10:
            return "sticky-red"
        default:
            return "sticky-gray"
        }
    }
}

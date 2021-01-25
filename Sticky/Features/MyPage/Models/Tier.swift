//
//  Tier.swift
//  Sticky
//
//  Created by deo on 2021/01/22.
//

import Foundation

struct Tier {
    let major: Int
    let minor: Int
}

extension Tier {
    /** 누적 시간을 Tier로 변환

     - level 1
         - 0~10
         - 11~20
         - 21~30
     - level 2
         - 31~60
         - 61~90
         - 91~120
     - level 3
         - 121~200
         - 201~280
         - 281~360
     - Level 4
         - 361~
     */
    static func of(hours: Int) -> Tier {
        switch hours {
        case 0..<11:
            return Tier(major: 1, minor: 0)
        case 11..<21:
            return Tier(major: 1, minor: 1)
        case 21..<31:
            return Tier(major: 1, minor: 2)
        case 31..<61:
            return Tier(major: 2, minor: 0)
        case 61..<91:
            return Tier(major: 2, minor: 1)
        case 91..<121:
            return Tier(major: 2, minor: 2)
        case 121..<201:
            return Tier(major: 3, minor: 0)
        case 201..<281:
            return Tier(major: 3, minor: 1)
        case 281..<361:
            return Tier(major: 3, minor: 2)
        default:
            return Tier(major: 4, minor: 4)
        }
    }
}

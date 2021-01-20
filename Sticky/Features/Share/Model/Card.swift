//
//  Card.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/20.
//

import Foundation

// 카드 내에 정보를 담는 모델
struct Card: Decodable, Hashable, Identifiable {
    var id: Int
    var name: String = ""
}

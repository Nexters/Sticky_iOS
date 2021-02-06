//
//  Array+.swift
//  Sticky
//
//  Created by deo on 2021/02/04.
//

import Foundation

public extension Array {
    func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key: Element] {
        var dict = [Key: Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

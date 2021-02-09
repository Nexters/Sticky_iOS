//
//  DateComponenets+.swift
//  Sticky
//
//  Created by 지현우 on 2021/02/09.
//

import Foundation

extension DateComponents{
    func toSeconds() -> Int{
        var seconds = 0
        seconds += self.second ?? 0
        seconds += self.minute ?? 0 * 60
        seconds += self.hour ?? 0 * 60 * 60
        seconds += self.day ?? 0 * 60 * 60 * 24
        
        return seconds
    }
}

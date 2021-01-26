//
//  Time.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/26.
//

import Foundation

public class Time: ObservableObject {
    @Published var timeData=TimeData()
}

struct TimeData: Codable {
    var day: Int=0
    var hour: Int=0
    var minute: Int=0
    var second: Int=0
}

//
//  User.swift
//  Sticky
//
//  Created by 지현우 on 2021/02/08.
//

import Foundation

public class User: ObservableObject {
    // 총 누적 시간
    @Published var accumulateSeconds: Int = UserDefaults.standard.integer(forKey: "accumulateSeconds") {
        didSet {
            UserDefaults.standard.set(accumulateSeconds, forKey: "accumulateSeconds")
        }
    }

    // 이번 달 누적 시간
    @Published var thisMonthAccumulateSeconds: Int = UserDefaults.standard.integer(forKey: "thisMonthAccumulateSeconds") {
        didSet {
            UserDefaults.standard.set(thisMonthAccumulateSeconds, forKey: "thisMonthAccumulateSeconds")
        }
    }
}

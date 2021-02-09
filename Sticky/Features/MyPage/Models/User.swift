//
//  User.swift
//  Sticky
//
//  Created by 지현우 on 2021/02/08.
//

import Foundation

public class User: ObservableObject {
    @Published var accumulateTime: Int = UserDefaults.standard.integer(forKey: "accumulateTime") {
        didSet {
            UserDefaults.standard.set(accumulateTime, forKey: "accumulateTime")
        }
    }
}

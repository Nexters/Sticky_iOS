//
//  User.swift
//  Sticky
//
//  Created by 지현우 on 2021/02/08.
//

import Foundation

public class User: ObservableObject {
    @Published var accumulateSeconds: Int = UserDefaults.standard.integer(forKey: "accumulateSeconds") {
        didSet {
            UserDefaults.standard.set(accumulateSeconds, forKey: "accumulateSeconds")
        }
    }
}

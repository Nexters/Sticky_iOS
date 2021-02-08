//
//  User.swift
//  Sticky
//
//  Created by 지현우 on 2021/02/08.
//

import Foundation

class User: ObservableObject{
    var accumulateTime: Int{
        get{
            UserDefaults.standard.integer(forKey: "accumulateTime")
        }
        set{
            UserDefaults.standard.setValue(newValue,forKey: "accumulateTime")
        }
    }
    var nickName: String = "닉네임"
}

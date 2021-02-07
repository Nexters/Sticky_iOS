//
//  MyOperation.swift
//  Sticky
//
//  Created by 지현우 on 2021/02/06.
//

import Foundation

class MyOperation: Operation {
    override func main() {
        print("MyOpration - main")
        var num = UserDefaults.standard.integer(forKey: "operation") 
        num += 1
        UserDefaults.standard.setValue(num, forKey: "operation")
    }
}

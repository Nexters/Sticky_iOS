//
//  Message.swift
//  Sticky
//
//  Created by 지현우 on 2021/02/01.
//

import Foundation

struct Message {
    var style: PopupStyle
    var title: String
    var description: String
    var confirmIcon: String = ""
    var confirmString: String
    var rejectIcon: String = ""
    var rejectString: String
}

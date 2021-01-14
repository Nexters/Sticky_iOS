//
//  String+localize.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import Foundation
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}

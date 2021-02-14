//
//  String+localize.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import Foundation
extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, value: self, comment: comment)
    }

    func localized(with arguments: CVarArg = [], comment: String = "") -> String {
        return String(format: self.localized(comment: comment), arguments)
    }
}

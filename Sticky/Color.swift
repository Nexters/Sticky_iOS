//
//  Color.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import Foundation
import SwiftUI

extension Color {
    static let main = Color("main")
    static let gray100 = Color("gray-100")
    static let gray200 = Color("gray-200")
    static let grayC4 = Color("gray-c4")
    static let gradientStart = Color("gradientStart")
    static let gradientEnd = Color("gradientEnd")
    static let gradientHorizontal = LinearGradient(
        gradient: Gradient(
            colors: [Color.gradientStart, Color.gradientEnd]
        ),
        startPoint: .leading,
        endPoint: .trailing
    )
}

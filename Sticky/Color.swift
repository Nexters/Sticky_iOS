//
//  Color.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import Foundation
import SwiftUI

extension Color {
    static let tempColor = Color("tempColor")
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

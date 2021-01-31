//
//  Color.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import Foundation
import SwiftUI

extension Color {
    enum Palette {
        static let primary = Color("palette-primary")
        static let secondary = Color("palette-primary")
        static let tertiary = Color("palette-primary")
        static let negative = Color("palette-nagative")
    }

    enum Background {}

    enum TextIconLight {
        static let primary = Color("text-primary-light")
        static let secondary = Color("text-secondary-light")
        static let tertiary = Color("text-tertiary-light")
    }

    enum TextIconColor {
        static let primary = Color("text-primary-color")
        static let secondary = Color("text-secondary-color")
        static let tertiary = Color("text-tertiary-color")
    }

    enum Border {
        static let primary = Color("border")
    }

    enum GrayScale {
        static let _900 = Color("grayscale-900")
        static let _800 = Color("grayscale-800")
        static let _700 = Color("grayscale-700")
        static let _600 = Color("grayscale-600")
        static let _500 = Color("grayscale-500")
        static let _400 = Color("grayscale-400")
        static let _300 = Color("grayscale-300")
        static let _200 = Color("grayscale-200")
        static let _100 = Color("grayscale-100")
        static let _50 = Color("grayscale-50")
    }

    static let gradientHorizontal = LinearGradient(
        gradient: Gradient(
            colors: [Color.Palette.primary, Color.Palette.secondary]
        ),
        startPoint: .leading,
        endPoint: .trailing
    )
}

//
//  Color.swift
//  Sticky
//
//  Created by deo on 2021/01/14.
//

import Foundation
import SwiftUI

extension Color {
    enum Sticky {
        static let blue_start = Color("sticky-blue-start")
        static let blue_end = Color("sticky-blue-end")
        static let blue = LinearGradient(
            gradient: Gradient(
                colors: [blue_start, blue_end]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        static let blue_bg_start = Color("sticky-blue-bg-start")
        static let blue_bg_end = Color("sticky-blue-bg-end")
        static let blue_bg = LinearGradient(
            gradient: Gradient(colors: [blue_bg_start, blue_bg_end]),
            startPoint: .top,
            endPoint: .bottom
        )
        static let red_bg_start = Color("sticky-red-start")
        static let red_bg_end = Color("sticky-red-end")
        static let red_bg = LinearGradient(
            gradient: Gradient(colors: [red_bg_start, red_bg_end]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

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

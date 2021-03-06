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
        static let red_bg_start = Color("sticky-red-bg-start")
        static let red_bg_end = Color("sticky-red-bg-end")
        static let red_bg = LinearGradient(
            gradient: Gradient(colors: [red_bg_start, red_bg_end]),
            startPoint: .top,
            endPoint: .bottom
        )
        
        static let red_start = Color("sticky-red-start")
        static let red_end = Color("sticky-red-end")
        static let red = LinearGradient(
            gradient: Gradient(colors: [red_start, red_end]),
            startPoint: .top,
            endPoint: .bottom
        )
        
        static let yellow_start = Color("sticky-yellow-start")
        static let yellow_end = Color("sticky-yellow-end")
        static let yellow = LinearGradient(
            gradient: Gradient(colors: [yellow_start, yellow_end]),
            startPoint: .top,
            endPoint: .bottom
        )
        
        static let green_start = Color("sticky-green-start")
        static let green_end = Color("sticky-green-end")
        static let green = LinearGradient(
            gradient: Gradient(colors: [green_start, green_end]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    enum Card{
        static let blue_card = Color("sticky-blue")
        static let red_card = Color("sticky-red")
        static let yellow_card = Color("sticky-yellow")
        static let green_card = Color("sticky-green")
        
        static let badge_card = LinearGradient(
            gradient: Gradient(colors: [Color.black, Color("badgeCard-black-end")]),
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

    enum Background {
        static let blue = Color("sticky-timer-bg-blue").opacity(0.2)
        static let yellow = Color("sticky-timer-bg-yellow").opacity(0.2)
        static let green = Color("sticky-timer-bg-green").opacity(0.2)
        static let red = Color("sticky-timer-bg-red").opacity(0.2)
        static let outing = LinearGradient(
            gradient: Gradient(colors: [Color("outing-bg-start"), Color("outing-bg-end")]),
            startPoint: .top,
            endPoint: .bottom
        )
        static let outingAnimation = Color("outing-animation").opacity(0.1)
    }

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

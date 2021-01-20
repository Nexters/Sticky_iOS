//
//  StickyApp.swift
//  Sticky
//
//  Created by deo on 2021/01/13.
//

import SwiftUI

@main
struct StickyApp: App {
    var body: some Scene {
        WindowGroup {
            Share()
                .environmentObject(UIStateModel())
        }
    }
}

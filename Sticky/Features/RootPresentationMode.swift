//
//  RootPresentationMode.swift
//  Sticky
//
//  Created by deo on 2021/01/30.
//

import SwiftUI

// MARK: - RootPresentationModeKey

struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
}

typealias RootPresentationMode = Bool

public extension RootPresentationMode {
    mutating func dismiss() {
        self.toggle()
    }
}

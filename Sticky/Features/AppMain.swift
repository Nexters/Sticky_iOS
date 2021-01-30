//
//  AppMain.swift
//  Sticky
//
//  Created by deo on 2021/01/30.
//

import SwiftUI

// MARK: - AppMain

struct AppMain: View {
    // MARK: Lifecycle

    init() {
        let newNavAppearance = UINavigationBarAppearance()
        newNavAppearance.configureWithTransparentBackground()
        newNavAppearance.backgroundColor = .clear
        UINavigationBar.appearance()
            .standardAppearance = newNavAppearance
    }

    // MARK: Internal

    var body: some View {
        let rootView = UserDefaults.standard.bool(forKey: "hasGeofence") ?
            AnyView(Onboarding()) : AnyView(Onboarding())

        NavigationView {
            VStack {
                NavigationLink(destination: rootView, isActive: self.$isActive) { EmptyView() }

                rootView
            }
        }.environment(\.rootPresentationMode, self.$isActive)
    }

    // MARK: Private

    @State private var isActive: Bool = true
}

// MARK: - AppMain_Previews

struct AppMain_Previews: PreviewProvider {
    static var previews: some View {
        AppMain()
    }
}

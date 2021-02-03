//
//  AppMain.swift
//  Sticky
//
//  Created by deo on 2021/01/30.
//

import SwiftUI

// MARK: - AppMain

struct AppMain: View {
    // MARK: Internal

    @EnvironmentObject var rootViewManager: RootViewManager
    @EnvironmentObject var challengeState: ChallengeState
    @EnvironmentObject var locationManager: LocationManager

//    init() {
//        let newNavAppearance = UINavigationBarAppearance()
//        newNavAppearance.configureWithTransparentBackground()
//        newNavAppearance.backgroundColor = .clear
//        UINavigationBar.appearance()
//            .standardAppearance = newNavAppearance
//    }

    var body: some View {
        getRootView()
            .environment(\.rootPresentationMode, self.$isActive)
            .onAppear {
                locationManager.restartManager()
            }
            .onReceive(NotificationCenter.default.publisher(for: .enterGeofence), perform: { _ in
                if challengeState.type == .notAtHome {
                    print("집 밖에 있다가 들어감")
                    challengeState.type = .notRunning
                }
            })
            .onReceive(NotificationCenter.default.publisher(for: .exitGeofence), perform: { _ in
                if challengeState.type == .running || challengeState.type == .outing {
                    print("챌린지/외출 진행 중 나감")
                    challengeState.type = .notAtHome
                }
            })
    }

    // MARK: Private

    @State private var isActive: Bool = true

    private func getRootView() -> AnyView {
        rootViewManager.hasGeofence ? AnyView(Main()) : AnyView(LocationPermission())
    }
}

// MARK: - AppMain_Previews

struct AppMain_Previews: PreviewProvider {
    static var previews: some View {
        AppMain()
            .environmentObject(RootViewManager())
    }
}

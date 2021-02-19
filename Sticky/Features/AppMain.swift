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

//    init() {
//        UINavigationBar.setAnimationsEnabled(false)
//    }

    @EnvironmentObject var rootViewManager: RootViewManager
    @EnvironmentObject var challengeState: ChallengeState
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var popupState: PopupStateModel

    var body: some View {
        getRootView()
            .environment(\.rootPresentationMode, self.$isActive)
            .onAppear {
                let newNavAppearance = UINavigationBarAppearance()
                newNavAppearance.configureWithTransparentBackground()
                newNavAppearance.backgroundColor = .clear
                UINavigationBar.appearance().standardAppearance = newNavAppearance
                locationManager.restartManager()
            }
            .onReceive(NotificationCenter.default.publisher(for: .enterGeofence), perform: { _ in
                print("LocationManager - AppMain enter")
                if challengeState.type == .notAtHome {
                    print("집 밖에 있다가 들어감")
                    challengeState.seconds = 0
                    challengeState.type = .notRunning
                }
            })
            .onReceive(NotificationCenter.default.publisher(for: .exitGeofence), perform: { _ in
                print("LocationManager - AppMain exit")
                if challengeState.type == .running {
//                    if !locationManager.isContains() {
                    print("챌린지 진행 중 나감")
                    popupState.popupStyle = .fail
                    popupState.isPresented = true
                    challengeState.type = .notAtHome
                    print("로케이션 나가기 - \(popupState.isPresented)")
//                    }
                } else if challengeState.type == .notRunning {
                    print("시작하지 않은 상태인데 집 밖으로 나감")
                    challengeState.type = .notAtHome
                }
            })
    }

    // MARK: Private

    @State private var isActive: Bool = true

    private func getRootView() -> AnyView {
        if rootViewManager.hasGeofence, locationManager.checkLocationStatus() {
            return AnyView(Main())
        } else {
            return AnyView(LocationPermission())
        }
    }
}

// MARK: - AppMain_Previews

struct AppMain_Previews: PreviewProvider {
    static var previews: some View {
        AppMain()
            .environmentObject(RootViewManager())
    }
}

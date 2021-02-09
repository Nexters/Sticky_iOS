//
//  StickyApp.swift
//  Sticky
//
//  Created by deo on 2021/01/13.
//

import MapKit
import SwiftUI

// MARK: - StickyApp

@main
struct StickyApp: App {
    // MARK: Internal

    var body: some Scene {
        WindowGroup {
            AppMain()
                .environmentObject(PopupStateModel())
                .environmentObject(UIStateModel())
                .environmentObject(challengeState)
                .environmentObject(locationManager)
                .environmentObject(LocationSearchService())
                .environmentObject(Location())
                .environmentObject(RootViewManager())
                .environmentObject(BadgeViewModel())
                .environmentObject(ShareViewModel())
                .environmentObject(user)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("Active \(user.accumulateSeconds)")
                print("Active \(Main.ChallengeType(rawValue: UserDefaults.standard.integer(forKey: "challengeType")))")
                // TODO: 현재 챌린지가 진행중인 상태라면 조건문 필요
//                if let date = UserDefaults.standard.object(forKey: "startDate") {
//                    if let date = date as? Date {
//                        // 우선은 앱에 다시 들어오면 재시작하게끔 설정
//                        challengeState.type = .running
//                        let components = dateCompareToNow(date: date)
//                        challengeState.timeData.day = components?.day ?? 0
//                        challengeState.timeData.hour = components?.hour ?? 0
//                        challengeState.timeData.minute = components?.minute ?? 0
//                        challengeState.timeData.second = components?.second ?? 0
//                    }
//                }
                let latitude = UserDefaults.standard.double(forKey: "latitude")
                let longitude = UserDefaults.standard.double(forKey: "longitude")
                print("latitude: \(latitude)")
                print("longitude: \(longitude)")
                locationManager.geofence = CLCircularRegion(
                    center: CLLocationCoordinate2D(
                        latitude: latitude,
                        longitude: longitude
                    ),
                    radius: 100.0,
                    identifier: "Myhome"
                )
                locationManager.region = MKCoordinateRegion(center: locationManager.geofence!.center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                print("체크\(locationManager.isContains())")

            case .inactive:
                print("inActive")
                if let data = try? PropertyListEncoder().encode(challengeState.timeData) {
//                    UserDefaults.standard.set(data, forKey: key_time)
//                    UserDefaults.standard.setValue(Date(), forKey: key_date)
                }
                if let geofence = locationManager.geofence {
                    print("latitude: \(geofence.center.latitude)")
                    print("longitude: \(geofence.center.longitude)")
                    UserDefaults.standard.set(geofence.center.latitude, forKey: "latitude")
                    UserDefaults.standard.set(geofence.center.longitude, forKey: "longitude")
                }
            case .background:
                print("Background")

            @unknown default:
                print("다른 상태 구현 필요")
            }
        }
    }

    // MARK: Private

    private var latitude = UserDefaults.standard.double(forKey: "latitude")
    private var longitude = UserDefaults.standard.double(forKey: "longitude")

    @Environment(\.scenePhase) private var scenePhase
    private var challengeState = ChallengeState()
    private var locationManager = LocationManager()
    private var user = User()
    private let key_time = "time"
    private let key_date = "date"
}

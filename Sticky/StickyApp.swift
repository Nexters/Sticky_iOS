//
//  StickyApp.swift
//  Sticky
//
//  Created by deo on 2021/01/13.
//

import MapKit
import SwiftUI

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        challengeState.type = .notRunning
        print("type앱 종료되요")
    }
}

// MARK: - StickyApp

@main
struct StickyApp: App {
    // MARK: Internal

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appdelegate

    var body: some Scene {
        WindowGroup {
            AppMain()
                .environmentObject(PopupStateModel())
                .environmentObject(UIStateModel())
                .environmentObject(challengeState)
                .environmentObject(locationManager)
                .environmentObject(LocationSearchService())
                .environmentObject(Location())
                .environmentObject(rootViewManager)
                .environmentObject(ShareViewModel())
                .environmentObject(user)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("Why - latitude : \(UserDefaults.standard.double(forKey: "whyLatitude")), longitude : \(UserDefaults.standard.double(forKey: "whyLongitude"))")
                print("locationManager - ChallengeType \(challengeState.type)")
                print("Active \(String(describing: Main.ChallengeType(rawValue: UserDefaults.standard.integer(forKey: "challengeType"))))")
                let latitude = UserDefaults.standard.double(forKey: "latitude")
                let longitude = UserDefaults.standard.double(forKey: "longitude")
                print("App - latitude: \(latitude)")
                print("App - longitude: \(longitude)")
                if latitude != 0, longitude != 0 {
                    locationManager.challengeType = challengeState.type
                    locationManager.geofence = CLCircularRegion(
                        center: CLLocationCoordinate2D(
                            latitude: latitude,
                            longitude: longitude
                        ),
                        radius: 100.0,
                        identifier: "Myhome"
                    )
                    locationManager.region = MKCoordinateRegion(center: locationManager.geofence!.center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                }
            case .inactive:
                print("inActive")
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
    private var locationManager = LocationManager()
    private var rootViewManager = RootViewManager()
    private var user = User()
    private let key_time = "time"
    private let key_date = "date"
}

var challengeState = ChallengeState()

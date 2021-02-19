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
        StickyApp.challengeState.type = .notRunning
        print("type앱 종료되요")
    }
}

// MARK: - StickyApp

@main
struct StickyApp: App {
    // MARK: Public

    public static var locationManager = LocationManager()
    public static var rootViewManager = RootViewManager()
    public static var user = User()
    public static var challengeState = ChallengeState()
    public static var popupStateModel = PopupStateModel()
    public static var uiStateModel = UIStateModel()
    public static var locationSearchService = LocationSearchService()
    public static var location = Location()

    // MARK: Internal

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appdelegate

    var body: some Scene {
        WindowGroup {
            AppMain()
                .environmentObject(StickyApp.popupStateModel)
                .environmentObject(StickyApp.uiStateModel)
                .environmentObject(StickyApp.challengeState)
                .environmentObject(StickyApp.locationManager)
                .environmentObject(StickyApp.locationSearchService)
                .environmentObject(StickyApp.location)
                .environmentObject(StickyApp.rootViewManager)
                .environmentObject(StickyApp.user)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("Why - latitude : \(UserDefaults.standard.double(forKey: "whyLatitude")), longitude : \(UserDefaults.standard.double(forKey: "whyLongitude"))")
                print("locationManager - ChallengeType \(StickyApp.challengeState.type)")
                print("Active \(String(describing: Main.ChallengeType(rawValue: UserDefaults.standard.integer(forKey: "challengeType"))))")
                let latitude = UserDefaults.standard.double(forKey: "latitude")
                let longitude = UserDefaults.standard.double(forKey: "longitude")
                print("App - latitude: \(latitude)")
                print("App - longitude: \(longitude)")
                if latitude != 0, longitude != 0 {
                    StickyApp.locationManager.challengeType = StickyApp.challengeState.type
                    StickyApp.locationManager.geofence = CLCircularRegion(
                        center: CLLocationCoordinate2D(
                            latitude: latitude,
                            longitude: longitude
                        ),
                        radius: 100.0,
                        identifier: "Myhome"
                    )
                    StickyApp.locationManager.region = MKCoordinateRegion(center: StickyApp.locationManager.geofence!.center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
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
}

//
//  StickyApp.swift
//  Sticky
//
//  Created by deo on 2021/01/13.
//

import SwiftUI

@main
struct StickyApp: App {
    // MARK: Internal

    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environmentObject(PopupStateModel())
                .environmentObject(time)
                .environmentObject(timerClass)
                .environmentObject(LocationManager())
                .environmentObject(LocationSearchService())
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("Active")
                // TODO: 현재 챌린지가 진행중인 상태라면 조건문 필요
                if let date = UserDefaults.standard.object(forKey: "startDate") {
                    if let date = date as? Date {
                        // 우선은 앱에 다시 들어오면 재시작하게끔 설정
                        timerClass.type = .running
                        let components = dateCompareToNow(date: date)
                        time.timeData.day = components?.day ?? 0
                        time.timeData.hour = components?.hour ?? 0
                        time.timeData.minute = components?.minute ?? 0
                        time.timeData.second = components?.second ?? 0
                    }
                }
            case .inactive:
                print("inActive")
            case .background:
                print("Background")
                if let data = try? PropertyListEncoder().encode(time.timeData) {
                    UserDefaults.standard.set(data, forKey: key_time)
                    UserDefaults.standard.setValue(Date(), forKey: key_date)
                }

            @unknown default:
                print("다른 상태 구현 필요")
            }
        }
    }

    // MARK: Private

    @Environment(\.scenePhase) private var scenePhase
    private var time = Time()
    private var timerClass = TimerClass()
    private let key_time = "time"
    private let key_date = "date"

    private func dateCompareToNow(date: Date) -> DateComponents? {
        var calendar = Calendar.current
        if let timeZone = TimeZone(identifier: "UTC") {
            calendar.timeZone = timeZone
        }

        let now = Date()

        return Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)
    }
}

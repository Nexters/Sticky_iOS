//
//  ChallengeState.swift
/**
 *  type : Main.ChallengeType -> 현재 챌린지 상태 (진행중, 지오펜스 밖, 지오펜스 안&시작 X, 외출중)
 *  timeData: TimeData -> 현재 Challenge 진행 중인 시간
 * startDate: Date -> 시작 날짜

 ***/
//  Sticky
//
//  Created by 지현우 on 2021/02/03.
//

import Foundation

// MARK: - ChallengeState

public class ChallengeState: ObservableObject {
    // MARK: Lifecycle

    init() {
        let now = Date()
        if type == .running {
            let seconds = now.compareTo(date: startDate).toSeconds()
            UserDefaults.standard.set(seconds, forKey: "shareSeconds")
        }
        if type == .outing {
            let outingComponents = now.compareTo(date: outingDate)

            let outingSeconds = (outingComponents.minute ?? 0) * 60 + (outingComponents.second ?? 0)
            let totalOutingTime = 20 * 60

            if outingSeconds < totalOutingTime {
                print("외출 중인데 아직 20분 안지남")
                outingTimeDate.day = outingComponents.day ?? 0
                outingTimeDate.hour = outingComponents.hour ?? 0
                outingTimeDate.minute = 19 - (outingComponents.minute ?? 0)
                outingTimeDate.second = 59 - (outingComponents.second ?? 0)
            } else {
                type = .notAtHome
                print("외출했는데 20분 지났")
            }
        }
    }

    // MARK: Internal

    @Published var seconds = 0
    @Published var outingTimeDate = TimeData(minute: 20)

    @Published var numberOfHeart: Int = UserDefaults.standard.integer(forKey: "numberOfHeart") {
        didSet {
            UserDefaults.standard.setValue(numberOfHeart, forKey: "numberOfHeart")
        }
    }

    @Published var type = Main.ChallengeType(rawValue: UserDefaults.standard.integer(forKey: "challengeType")) ?? .notRunning {
        didSet {
            print("type 저장")
            UserDefaults.standard.setValue(type.rawValue, forKey: "challengeType")
            if type == .running {
                startDate = Date()
            } else if type == .outing {
                outingDate = Date()
            }
        }
    }

    var startDate: Date = UserDefaults.standard.object(forKey: "startDate") as? Date ?? Date() {
        didSet {
            print("startDate 저장")
            UserDefaults.standard.setValue(startDate, forKey: "startDate")
        }
    }

    var outingDate: Date = UserDefaults.standard.object(forKey: "outingDate") as? Date ?? Date() {
        didSet {
            print("outingDate 저장")
            UserDefaults.standard.setValue(outingDate, forKey: "outingDate")
        }
    }
}

// MARK: - TimeData

struct TimeData: Codable {
    var day: Int = 0
    var hour: Int = 0
    var minute: Int = 0
    var second: Int = 0

    func toSeconds() -> Int {
        return day * 24 * 60 * 60 + hour * 60 * 60 + minute * 60 + second
    }
}

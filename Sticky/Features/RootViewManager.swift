//
//  RootViewManager.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/31.
//

import Foundation

class RootViewManager: ObservableObject {
    // MARK: Lifecycle

    init() {
        hasGeofence = UserDefaults.standard.bool(forKey: "hasGeofence")
    }

    // MARK: Internal

    @Published var hasGeofence: Bool
    
    func setGeofence(){
        hasGeofence = true
        UserDefaults.standard.setValue(true, forKey: "hasGeofence")
    }
}

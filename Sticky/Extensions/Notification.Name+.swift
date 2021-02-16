//
//  Notification.Name+.swift
//  Sticky
//
//  Created by 지현우 on 2021/01/24.
//

import Foundation

extension Notification.Name {
    static let enterGeofence = Notification.Name("enterGeofence")
    static let exitGeofence = Notification.Name("exitGeofence")
    
    static let captureScreen = Notification.Name("captureScreen")
    static let shareLocal = Notification.Name("shareLocal")
    static let shareInstagram = Notification.Name("shareInstagram")
    
    static let captureCongratulation = Notification.Name("captureCongratulation")
    static let shareInstagramCongratulation = Notification.Name("shareInstagramCongratulation")
    static let shareLocalCongratulation = Notification.Name("shareLocalCongratulation")
    
    static let endAboutSticky = Notification.Name("endAboutSticky")
}

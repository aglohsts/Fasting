//
//  AppConfig.swift
//  Fasting
//
//  Created by Apps4World on 2/9/21.
//

import SwiftUI
import Foundation

/// Basic app configurations
class AppConfig: NSObject {    
    /// Show/Hide logs while developing/debugging
    static let showLogs: Bool = true
    
    /// Settings items
    static let feedbackEmail: String = "yourEmail@gmail.com"
    static let privacyURL: String = "https://www.google.com/"
    static let termsURL: String = "https://www.google.com/"
    
    /// Notification reminder when a fast ends
    static let notificationBeforeFastEnds: Int = 30 /// 30 minutes before the fast ends the notification will trigger
    static let notificationTitle: String = "\(AppConfig.notificationTestMode ? "[TEST]" : "")Your fast ends in \(AppConfig.notificationBeforeFastEnds) minutes"
    static let notificationBody: String = "Open the app to stop your fast"
    static let notificationTestMode: Bool = false /// set this to `true` if you want to test notifications without waiting. Set it to `false` before submitting the app to the App Store
}


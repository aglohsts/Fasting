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

    /// This is the AdMob Interstitial ad id
    /// Test App ID: ca-app-pub-3940256099942544~1458002511
    /// Test Interstitial ID: ca-app-pub-3940256099942544/4411468910
    static let adMobAdID: String = "ca-app-pub-3940256099942544/4411468910"
    
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

/// Fasting plans
enum FastingPlan: String, CaseIterable, Identifiable {
    case thirteen = "13"
    case sixteen = "16"
    case eighteen = "18"
    case twenty = "20"
    var id: Int { hashValue }
    
    var planGradient: Gradient {
        switch self {
        case .thirteen:
            return Gradient(colors: [Color(#colorLiteral(red: 0.4847264653, green: 0.4169784902, blue: 0.6716101926, alpha: 1)), Color(#colorLiteral(red: 0.3965855241, green: 0.3398780823, blue: 0.5469947457, alpha: 1))])
        case .sixteen:
            return Gradient(colors: [Color(#colorLiteral(red: 0.9689245233, green: 0.5695010083, blue: 0.494715736, alpha: 1)), Color(#colorLiteral(red: 0.8772187267, green: 0.515599448, blue: 0.4478923771, alpha: 1))])
        case .eighteen:
            return Gradient(colors: [Color(#colorLiteral(red: 0.2997641731, green: 0.6547199572, blue: 0.6694195755, alpha: 1)), Color(#colorLiteral(red: 0.2570414543, green: 0.5614810586, blue: 0.5711966157, alpha: 1))])
        case .twenty:
            return Gradient(colors: [Color(#colorLiteral(red: 0.9674802608, green: 0.7327492438, blue: 0.4523254982, alpha: 1)), Color(#colorLiteral(red: 0.9159417069, green: 0.6937150248, blue: 0.4282297073, alpha: 1))])
        }
    }
}

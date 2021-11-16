//
//  FastingApp.swift
//  Fasting
//
//  Created by Apps4World on 2/4/21.
//

import SwiftUI
//import GoogleMobileAds

@main
struct FastingApp: App {
    
    @ObservedObject private var manager = FastingDataManager()
    
    // MARK: - Main rendering function
    var body: some Scene {
        return WindowGroup {
            VStack {
                if !manager.didShowWelcomePage {
                    WelcomeContentView(manager: manager)
                } else {
                    DashboardContentView(manager: manager)
                }
            }
            .sheet(item: $manager.modalScreenType, content: { screenType in
                switch screenType {
                case .aboutFasting:
                    AboutFastingContentView()
                }
            })
        }
    }
}

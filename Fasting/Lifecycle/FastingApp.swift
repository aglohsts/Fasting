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
//    private let interstitial = Interstitial()
    
    // MARK: - Main rendering function
    var body: some Scene {
//        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return WindowGroup {
            VStack {
                if !manager.didShowQuestionnaire {
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

// MARK: - Google AdMob Interstitial - Support class
//class Interstitial: NSObject, GADFullScreenContentDelegate {
//    var interstitial: GADInterstitialAd?
//
//    /// Default initializer of interstitial class
//    init(previewMode: Bool = false) {
//        super.init()
//        if previewMode { return }
//        loadInterstitial()
//    }
//
//    /// Request AdMob Interstitial ads
//    func loadInterstitial() {
//        let request = GADRequest()
//        GADInterstitialAd.load(withAdUnitID: AppConfig.adMobAdID, request: request, completionHandler: { [self] ad, error in
//            if ad != nil {
//                interstitial = ad
//                interstitial?.fullScreenContentDelegate = self
//            }
//        })
//    }
//
//    func showInterstitialAds() {
//        if self.interstitial != nil {
//            var root = UIApplication.shared.windows.first?.rootViewController
//            if let presenter = root?.presentedViewController {
//                root = presenter
//            }
//            self.interstitial?.present(fromRootViewController: root!)
//        }
//    }
//
//    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        loadInterstitial()
//    }
//}

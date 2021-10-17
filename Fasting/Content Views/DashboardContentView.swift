//
//  DashboardContentView.swift
//  Fasting
//
//  Created by Apps4World on 2/4/21.
//

import SwiftUI

/// Tab Bar Items
enum TabBarItem: String, CaseIterable {
    case fasting
    case history
    case settings
    
    /// Tab Title
    var tabTitle: String {
        "\(self)".capitalized
    }
    
    /// Tab Image
    var tabImage: Image {
        switch self {
        case .fasting:
            return Image(systemName: "flame.fill")
        case .history:
            return Image(systemName: "list.bullet")
        case .settings:
            return Image(systemName: "gearshape.fill")
        }
    }
}

/// Main content/app screen
struct DashboardContentView: View {
    
    @ObservedObject var manager: FastingDataManager
    @State private var selectedTab: TabBarItem = .fasting
    @State private var didShowAds: Bool = false
    let interstitial: Interstitial
    
    // MARK: - Main rendering function
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                CreateTabBarItem(view: AnyView(FastingTabView(manager: manager)), tabItem: .fasting)
                CreateTabBarItem(view: AnyView(HistoryContentView(manager: manager)), tabItem: .history)
                CreateTabBarItem(view: AnyView(SettingsContentView(manager: manager)), tabItem: .settings)
            }
            .navigationBarTitle(selectedTab.tabTitle)
        }
        .onAppear(perform: {
            if manager.selectedAnswer == .newbie {
                manager.modalScreenType = .aboutFasting
                manager.selectedAnswer = nil
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if !didShowAds {
                    didShowAds = true
                    interstitial.showInterstitialAds()
                }
            }
        })
    }
    
    /// Create tab bar item
    private func CreateTabBarItem(view: AnyView, tabItem: TabBarItem) -> some View {
        view.tabItem {
            Text(tabItem.tabTitle)
            tabItem.tabImage
        }.tag(tabItem)
    }
}

// MARK: - Render preview UI
struct DashboardContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardContentView(manager: FastingDataManager(), interstitial: Interstitial(previewMode: true))
    }
}

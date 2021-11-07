//
//  DashboardContentView.swift
//  Fasting
//
//  Created by Apps4World on 2/4/21.
//

import SwiftUI

/// Tab Bar Items
enum TabBarItem: String, CaseIterable {
    case recipe
    case plan
    case home
    case analysis
//    case settings
    case profile
    
    /// Tab Title
    var tabTitle: String {
        "\(self)".capitalized
    }
    
    /// Tab Image
    var tabImage: Image {
        switch self {
        case .recipe:
            return Image(systemName: "newspaper.fill")
        case .plan:
            return Image(systemName: "rectangle.and.paperclip")
        case .home:
            return Image(systemName: "house.fill")
        case .analysis:
            return Image(systemName: "chart.bar.xaxis")
//        case .settings:
//            return Image(systemName: "gearshape.fill")
        case .profile:
            return Image(systemName: "person.crop.circle.fill")
        }
    }
}

/// Main content/app screen
struct DashboardContentView: View {
    
    @ObservedObject var manager: FastingDataManager
    @State private var selectedTab: TabBarItem = .home
    @State private var didShowAds: Bool = false
    let interstitial: Interstitial
    
    // MARK: - Main rendering function
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                CreateTabBarItem(view: AnyView(SettingsContentView(manager: manager)), tabItem: .recipe)
                CreateTabBarItem(view: AnyView(PlanTabView(manager: manager)), tabItem: .plan)
                CreateTabBarItem(view: AnyView(FastingTabView(manager: manager)), tabItem: .home)
                CreateTabBarItem(view: AnyView(HistoryContentView(manager: manager)), tabItem: .analysis)
//                CreateTabBarItem(view: AnyView(SettingsContentView(manager: manager)), tabItem: .settings)
                CreateTabBarItem(view: AnyView(ProfileTabView(manager: manager)), tabItem: .profile)
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

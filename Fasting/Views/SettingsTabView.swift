//
//  SettingsTabView.swift
//  Fasting
//
//  Created by Apps4World on 2/9/21.
//

import SwiftUI
import StoreKit

// MARK: - Settings item
enum SettingsItem: String, CaseIterable, Identifiable {
    case about = "About Fasting"
    case feedback = "Feedback"
    case rateUs = "Rate Us"
    case privacy = "Privacy"
    case terms = "Terms of Use"
    var id: Int { hashValue }
    
    /// Item icon
    var icon: String {
        switch self {
        case .about:
            return "lightbulb.fill"
        case .feedback:
            return "text.bubble.fill"
        case .rateUs:
            return "star.fill"
        case .privacy:
            return "checkmark.shield.fill"
        case .terms:
            return "list.bullet.below.rectangle"
        }
    }
    
    /// Item URL/action
    var url: URL? {
        switch self {
        case .privacy:
            return URL(string: AppConfig.privacyURL)
        case .terms:
            return URL(string: AppConfig.termsURL)
        default:
            return nil
        }
    }
}

/// Main view for the settings tab
struct SettingsTabView: View {
    
    @ObservedObject var manager: FastingDataManager
    @State private var showAboutFastingView: Bool = false
    private let columns = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]
    
    @State var showingUserInputView = false
    
    // MARK: - Main rendering function
    var body: some View {
        ScrollView {
            NotificationsSection
            Divider().padding(30)
            GeneralSection
            Spacer(minLength: 30)
            
            Button(action: {
                showingUserInputView = true
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            }).sheet(isPresented: $showingUserInputView, content: {
                UserInfoInputView(manager: manager, title: "User Info", buttonText: "Save")
            })
        }
        .sheet(isPresented: $showAboutFastingView, content: {
            AboutFastingContentView()
        })
    }
    
    /// Reminders/Notifications section
    private var NotificationsSection: some View {
        VStack {
            Text("Fasting Reminders").font(.title2).fontWeight(.medium)
            Text("Get notifications 30min before your fast ends").font(.system(size: 15)).opacity(0.75)
            HStack {
                Image(systemName: "bell.badge.fill").font(.system(size: 20)).frame(width: 30)
                Text("Notifications")
                Spacer()
                Toggle(isOn: $manager.notificationsStatus, label: {
                    Text("")
                }).labelsHidden()
            }
            .padding([.leading, .trailing], 15).padding([.top, .bottom], 10)
            .background(Color(#colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)).cornerRadius(20)).padding([.leading, .trailing])
        }
    }
    
    /// Shows basic settings
    private var GeneralSection: some View {
        VStack {
            Text("General").font(.title2).fontWeight(.medium)
            VStack(alignment: .leading) {
                ForEach(SettingsItem.allCases, content: { category in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: category.icon).font(.system(size: 20)).frame(width: 30)
                            Text(category.rawValue).font(.system(size: 18)).fontWeight(.regular)
                            Spacer()
                            Image(systemName: "chevron.right").font(.system(size: 20))
                        }.padding([.top, .bottom], 6)
                        if category != SettingsItem.allCases.last { Divider() }
                    }.contentShape(Rectangle()).onTapGesture {
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        if let itemURL = category.url {
                            UIApplication.shared.open(itemURL, options: [:], completionHandler: nil)
                        } else {
                            if category == .rateUs {
                                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                    SKStoreReviewController.requestReview(in: scene)
                                }
                            } else if category == .feedback {
                                EmailPresenter.shared.present()
                            } else if category == .about {
                                showAboutFastingView = true
                            }
                        }
                    }
                })
            }
            .padding([.leading, .trailing], 15).padding([.top, .bottom], 10)
            .background(Color(#colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)).cornerRadius(20)).padding([.leading, .trailing])
        }
    }
}

// MARK: - Render preview UI
struct SettingsTabView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTabView(manager: FastingDataManager())
    }
}

//
//  ProfileTabView.swift
//  Fasting
//
//  Created by lohsts on 2021/11/1.
//

import SwiftUI

enum ProfileItem: String, CaseIterable, Identifiable {
    case about = "Personal Detail"
    case setting = "Setting"
    case rateUs = "Rate Us"
    case privacy = "Privacy"
    case terms = "Terms of Use"
    var id: Int { hashValue }
    
    /// Item icon
    var icon: String {
        switch self {
        case .about:
            return "lightbulb.fill"
        case .setting:
            return "settings"
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

struct ProfileTabView: View {
    @ObservedObject var manager: FastingDataManager
    
    var body: some View {
        ScrollView {
            Divider().padding()
            ProfileUserView()
            SettingSection
        }
    }
    
    /// Reminders/Setting section
    private var SettingSection: some View {
        VStack {
            NavigationLink(
                destination: SettingsTabView(manager: manager),
                label: {
                    HStack {
                        Image(systemName: "gearshape.fill").font(.system(size: 20)).frame(width: 30)
                        Text("Settings")
                        Spacer()
                        Image(systemName: "chevron.right").font(.system(size: 20))
                            
                    }.foregroundColor(.black)
                })
                .navigationTitle("Settings")
            .padding([.leading, .trailing], 15).padding([.top, .bottom], 10)
            .background(Color(#colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)).cornerRadius(8)).padding([.leading, .trailing])
            
        }
    }
    
//    private var userInputTestSection: some View {
//
//        VStack {
//            NavigationLink(
//                destination: UserInfoInputView(),
//                label: {
//                    HStack {
//                        Image(systemName: "gearshape.fill").font(.system(size: 20)).frame(width: 30)
//                        Text("UserInfoTestSection")
//                        Spacer()
//                        Image(systemName: "chevron.right").font(.system(size: 20))
//
//                    }.foregroundColor(.black)
//                })
//                .navigationTitle("UserInfoTestSection")
//            .padding([.leading, .trailing], 15).padding([.top, .bottom], 10)
//            .background(Color(#colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)).cornerRadius(20)).padding([.leading, .trailing])
//
//        }
//    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabView(manager: FastingDataManager())
    }
}

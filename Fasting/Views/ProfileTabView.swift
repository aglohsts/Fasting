//
//  ProfileTabView.swift
//  Fasting
//
//  Created by lohsts on 2021/11/1.
//

import SwiftUI

struct ProfileTabView: View {
    @ObservedObject var manager: FastingDataManager
    let infoArray: [UserShowingInfo] = [.bmi, .fat, .age, .gender, .height, .weight]
    var body: some View {
        ScrollView {
            Divider().padding()
            ProfileUserView(manager: manager)
            userInfoSection
            Divider().padding()
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
                .padding([.leading, .trailing], 15).padding([.top, .bottom], 10)
                .background(Color(#colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)).cornerRadius(8)).padding([.leading, .trailing])
        }
    }
    
    private var userInfoSection: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0...infoArray.count - 1, id: \.self, content: { index in
                    let info = infoArray[index]
                    VStack {
                        HStack {
                            Image(systemName: info.icon)
                                .padding(4)
                                .background(Color.accentColor)
                                .cornerRadius(7)
                                .foregroundColor(.white)
                            Text(info.rawValue)
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                                .opacity(0.8)
                            Spacer()
                        }
                        Spacer()
                        VStack {
                            Spacer()
                            let showingText = getShowingInfoContent(info)
                            HStack(alignment: .bottom, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                                Text(showingText)
                                    .font(.system(size: 36))
                                    .bold()
                                    .foregroundColor(.black)
                                Spacer()
                                VStack {
                                    Spacer()
                                    Text(info.unit)
                                        .fontWeight(.light)
                                        .opacity(0.8)
                                }
                            })
                        }
                        Spacer()
                    }
                    .foregroundColor(.gray)
                    .padding([.leading, .trailing])
                    .padding([.top, .bottom], 16)
                    .background(Color(#colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)))
                    .cornerRadius(8)
                })
            }
            .padding([.leading, .trailing], 15)
            
        }
    }
    
    private let columns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]
    
    private func getShowingInfoContent(_ info: UserShowingInfo) -> String {
        var showingText: String = ""
        switch info {
        case .bmi: showingText = manager.userInfo.bmi
        case .fat: showingText = manager.userInfo.fat
        case .age: showingText = manager.userInfo.age
        case .gender: showingText = manager.userInfo.gender.rawValue
        case .height: showingText = manager.userInfo.height
        case .weight: showingText = manager.userInfo.weight
        }
        return showingText
    }
}

enum UserShowingInfo: String {
    case bmi = "BMI"
    case fat = "Fat"
    case age = "Age"
    case gender = "Gender"
    case height = "Height"
    case weight = "Weight"
    
    var icon: String {
        switch self {
        case .bmi: return "flame.fill"
        case .fat: return "deskclock.fill"
        case .age: return "clock.fill"
        case .gender: return "heart.text.square.fill"
        case .height: return "ruler.fill"
        case .weight: return "lineweight"
        }
    }
    
    var unit: String {
        switch self {
        case .bmi: return ""
        case .fat: return "%"
        case .age: return "years old"
        case .gender: return ""
        case .height: return "cm"
        case .weight: return "kg"
        }
    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabView(manager: FastingDataManager())
    }
}

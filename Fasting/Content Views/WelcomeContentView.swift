//
//  WelcomeContentView.swift
//  Fasting
//
//  Created by Apps4World on 2/4/21.
//

import SwiftUI

/// First screen the user will see on a fresh app install
struct WelcomeContentView: View {
    
    @ObservedObject var manager: FastingDataManager
    let welcomeImageList: [String] = ["welcome_1", "welcome_2", "welcome_3", "welcome_4"]
    @State private var index: Int = 0
    
    // MARK: - Main rendering function
    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $index,
                        content:  {
                            ForEach(0...welcomeImageList.count - 1, id: \.self) { index in
                                imageView(welcomeImageList[index]).tag(index)
                            }
                        })
                        .tabViewStyle(PageTabViewStyle())
                
                if index == (welcomeImageList.count - 1) {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(
                                destination: UserInfoInputView(manager: manager, title: "About You", buttonText: "Done"),
                                label: {
                                    Text("Get Started")
                                        .foregroundColor(.white).bold()
                                        .background(Color.accentColor)
                                })
                        }
                    }
                    .padding([.trailing, .bottom], 20)
                }
            }
            .navigationBarHidden(true)
            .background(Color(#colorLiteral(red: 0.9215561748, green: 0.6769378781, blue: 0.7386118174, alpha: 1)))
            .ignoresSafeArea()
        }
    }
    
    private func imageView(_ name: String) -> some View {
        Image(name)
            .resizable(capInsets: EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0), resizingMode: .stretch)
    }
}

// MARK: - Render preview UI
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeContentView(manager: FastingDataManager())
    }
}

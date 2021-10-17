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
    @State private var isQuestionnaireActive: Bool = false
    
    // MARK: - Main rendering function
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                NavigationLink(destination: QuestionnaireContentView(manager: manager),
                               isActive: $isQuestionnaireActive, label: { EmptyView() })
                Spacer()
                Image("fasting_illustration").resizable().aspectRatio(contentMode: .fit)
                Spacer()
                Text("Stop dieting.\nStart Fasting Today").font(.largeTitle).bold()
                Text("Weight loss and self-care has never been this easy and simple.")
                Button(action: {
                    isQuestionnaireActive = true
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                        Text("Get Started").foregroundColor(.white).bold()
                    }
                }).frame(height: 50).padding(.top, 40)
            }
            .navigationBarTitle("", displayMode: .large)
            .multilineTextAlignment(.center)
            .padding(40)
        }
    }
}

// MARK: - Render preview UI
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeContentView(manager: FastingDataManager())
    }
}

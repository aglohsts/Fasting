//
//  FastingTabView.swift
//  Fasting
//
//  Created by Apps4World on 2/6/21.
//

import SwiftUI

/// The main view for fasting
struct FastingTabView: View {
    
    @ObservedObject var manager: FastingDataManager
    private let circleSize = UIScreen.main.bounds.width / 1.3
    private let startButtonGradient = Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.615961194, blue: 0.2036704606, alpha: 1)), Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))])
    private let stopButtonGradient = Gradient(colors: [Color(#colorLiteral(red: 0.9529411793, green: 0.2524331993, blue: 0.1333333403, alpha: 1)), Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))])
    private let progressGradient = Gradient(colors: [Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)), Color(#colorLiteral(red: 0.9254902005, green: 0.5077413016, blue: 0.1019607857, alpha: 1))])
    
    // MARK: - Main rendering function
    var body: some View {
        ScrollView {
            VStack {
                Divider().padding()
      
                /// Show fasting status
                if manager.isTracking {
                    VStack(spacing: 10) {
                        Spacer()
                        Text("You're fasting!").font(.title).foregroundColor(Color(#colorLiteral(red: 0.3768654466, green: 0.3768654466, blue: 0.3768654466, alpha: 1)))
                        Divider().padding([.leading, .trailing], 100)
                        Text("Fasting will end \(manager.fastingModel.formattedFastingEndTime(plan: manager.currentFastingPlan))")
                            .font(.system(size: 18)).foregroundColor(Color(#colorLiteral(red: 0.3768654466, green: 0.3768654466, blue: 0.3768654466, alpha: 1)))
                        Spacer()
                    }
                }
                
                /// Show time since last fast
                if !manager.isTracking {
                    VStack(spacing: 10) {
                        Spacer()
                        Text("Your Eating Window").font(.title).foregroundColor(Color(#colorLiteral(red: 0.3768654466, green: 0.3768654466, blue: 0.3768654466, alpha: 1)))
                        Divider().padding([.leading, .trailing], 100)
                        Text(manager.notFastingModel.formattedCountdown(plan: manager.currentFastingPlan))
                            .font(.title3).foregroundColor(Color(#colorLiteral(red: 0.3768654466, green: 0.3768654466, blue: 0.3768654466, alpha: 1)))
                        Spacer()
                    }
                }
            
                /// Circular progress view
                ZStack {
                    ZStack {
                        Circle().strokeBorder(style: StrokeStyle(lineWidth: 30)).foregroundColor(Color(#colorLiteral(red: 0.9408885837, green: 0.9492552876, blue: 0.9408323169, alpha: 1)))
                        LinearGradient(gradient: progressGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                            .mask(
                                Circle().trim(from: 0.0, to: CGFloat(min(manager.fastingModel.secondsProgress, 1.0)))
                                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                                    .rotationEffect(Angle(degrees: 270.0)).animation(.linear).padding(15)
                            )
                    }.frame(width: circleSize, height: circleSize)
                    
                    /// Time and Activity tracker layer
                    VStack(spacing: 0) {
                        HStack(alignment: .bottom, spacing: 0) {
                            Text(String(format: "%02d", manager.fastingModel.timeComponents.h))
                                .font(.system(size: 40)).bold().lineLimit(1).minimumScaleFactor(0.5).frame(width: 60)
                            Text(":").font(.system(size: 35)).padding(.bottom, 6)
                            Text(String(format: "%02d", manager.fastingModel.timeComponents.m))
                                .font(.system(size: 40)).bold().lineLimit(1).minimumScaleFactor(0.5).frame(width: 60)
                            Text(":").font(.system(size: 35)).padding(.bottom, 6)
                            Text(String(format: "%02d", manager.fastingModel.timeComponents.s))
                                .font(.system(size: 40)).bold().lineLimit(1).minimumScaleFactor(0.5).frame(width: 60)
                        }.multilineTextAlignment(.center)
                        Capsule().frame(width: 50, height: 5, alignment: .center)
                            .padding(.bottom).padding(.top, 5).foregroundColor(Color(#colorLiteral(red: 0.8916636705, green: 0.8916636705, blue: 0.8916636705, alpha: 1)))
                        Button(action: {
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            manager.isTracking ? manager.stopTrackingActivityTime() : manager.startTrackingActivityTime()
                        }, label: {
                            Text(manager.isTracking ? "STOP" : "START").bold().padding([.leading, .trailing], 20).padding([.top, .bottom], 8).foregroundColor(.white)
                                .background(
                                    LinearGradient(gradient: manager.isTracking ? stopButtonGradient : startButtonGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                                        .mask(RoundedRectangle(cornerRadius: 15))
                                )
                        })
                    }
                }.frame(width: circleSize, height: circleSize)
                
                /// Fsating plan
                VStack(spacing: 10) {
                    Spacer()
                    HStack {
                        Text("Fasting plan").font(.title2).foregroundColor(Color(#colorLiteral(red: 0.3768654466, green: 0.3768654466, blue: 0.3768654466, alpha: 1)))
                        Text("\(manager.currentFastingPlan.rawValue):\(24-Int(manager.currentFastingPlan.rawValue)!)")
                            .font(.title2).foregroundColor(.white)
                            .padding([.leading, .trailing], 10).padding([.top, .bottom], 5)
                            .background(RoundedRectangle(cornerRadius: 10))
                    }
                    Spacer()
                }
            }.frame(height: UIScreen.main.bounds.height - 195)
        }
    }
}

// MARK: - Render preview UI
struct FastingTabView_Previews: PreviewProvider {
    static var previews: some View {
        FastingTabView(manager: FastingDataManager())
    }
}

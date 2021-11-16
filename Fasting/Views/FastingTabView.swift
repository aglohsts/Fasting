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
                Divider()
                    .padding()
                    .padding([.bottom], 16)
                /// Circular progress view
                ZStack {
                    ZStack {
                        Circle().strokeBorder(style: StrokeStyle(lineWidth: 30)).foregroundColor(Color(#colorLiteral(red: 0.9408885837, green: 0.9492552876, blue: 0.9408323169, alpha: 1)))
                        LinearGradient(gradient: progressGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                            .mask(
                                Circle().trim(from: 0.0, to: CGFloat( min(manager.fastingModel.secondsProgress, 1.0)))
                                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                                    .rotationEffect(Angle(degrees: 270.0))
                                    .animation(.linear)
                                    .padding(15)
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
                        }
                        .multilineTextAlignment(.center)
                        .padding([.top], 10)
                        
                        VStack {
                            Image(systemName: manager.isTracking ? "flame.fill" : "bolt.fill")
                                .font(.system(size: 30, weight: .bold, design: .default))
                                .foregroundColor(.accentColor)
                            
                            HStack {
                                Text("ends")
                                    .font(.system(size: 14))
                                    .foregroundColor(.accentColor)
                                
                                if manager.isTracking {
                                    Text("\(manager.fastingModel.formattedFastingEndTime(plan: manager.currentPlan))")
                                        .font(.system(size: 14))
                                        .foregroundColor(.accentColor)
                                } else {
                                    Text("\(manager.notFastingModel.formattedCountdown(plan: manager.currentPlan))")
                                        .font(.system(size: 14))
                                        .foregroundColor(.accentColor)
                                }
                            }
                        }
                        .padding([.top], 16)
                        
                        HStack {
                            Text("Next:")
                            Text(manager.isTracking ? "Eating" : "Fasting")
                        }
                        .padding([.top], 12)
                        
                    }
                }.frame(width: circleSize, height: circleSize)
                
                /// Fsating plan
                VStack(spacing: 10) {
                    HStack {
                        Text("\(manager.currentPlan.tag.rawValue.capitalized):")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                            .padding([.leading, .trailing], 10).padding([.top, .bottom], 5)
                        
                        Text("\(manager.currentPlan.name)")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black)
                    }
                    .padding([.top], 16)
                    .padding([.bottom], 20)
                    
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

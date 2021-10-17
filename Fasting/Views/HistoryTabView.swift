//
//  HistoryTabView.swift
//  Fasting
//
//  Created by Apps4World on 2/9/21.
//

import SwiftUI

/// Main view for the history tab
struct HistoryTabView: View {
    
    @ObservedObject var manager: FastingDataManager
    private let barGradient = Gradient(colors: [Color.accentColor, Color(#colorLiteral(red: 0.841987552, green: 0.5, blue: 0.9973822236, alpha: 1))])
    
    // MARK: - Main rendering function
    var body: some View {
        ScrollView {
            Divider().padding()
            FunStatsView
            Divider().padding(30)
            Graph(title: "Last 7 Days Fasting", weekly: true)
            Divider().padding(30)
            Graph(title: "This Month", weekly: false)
            Spacer(minLength: 30)
        }
    }
    
    /// Fun stats
    private var FunStatsView: some View {
        VStack {
            Text("Fun Stats").font(.title2).fontWeight(.medium)
            VStack {
                stats(title: "Fasted last 7 days", data: manager.fastingModel.formattedLast7Days)
                Divider()
                stats(title: "Fasted this month", data: manager.fastingModel.formattedThisMonth)
            }
            .foregroundColor(.white)
            .padding([.leading, .trailing], 5).padding([.top, .bottom], 10)
            .background(Color.accentColor.cornerRadius(20)).padding([.leading, .trailing])
        }
    }
    
    private func stats(title: String, data: String) -> some View {
        HStack {
            Text(title).font(.title3).fontWeight(.regular)
            Spacer()
            Text(data).font(.title3).fontWeight(.medium)
        }.padding([.leading, .trailing]).padding([.top, .bottom], 10)
    }
    
    /// Graph view
    private func Graph(title: String, weekly: Bool) -> some View {
        VStack {
            Text(title).font(.title2).fontWeight(.medium)
            ZStack {
                HStack {
                    Spacer()
                    if weekly {
                        ForEach(0..<WeekDays.sortedWeekDays.count, id: \.self, content: { index in
                            graphBar(value: manager.fastingModel.last7DaysTrackedSeconds.reversed()[index], text: WeekDays.sortedWeekDays[index].rawValue, isLast: index == 6)
                        })
                    } else {
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            HStack {
                                ForEach(0..<manager.fastingModel.thisMonthTrackedSeconds.count, id: \.self, content: { index in
                                    graphBar(value: manager.fastingModel.thisMonthTrackedSeconds.reversed()[index], text: "\(index+1)", isLast: index == (manager.fastingModel.thisMonthTrackedSeconds.count - 1), weekly: false)
                                })
                            }
                        })
                    }
                    Spacer()
                }
                if manager.fastingModel.last7DaysTrackedSeconds.reduce(0, +) == 0 {
                    Text("No Data Yet").font(.title).padding(.bottom, 20)
                }
            }
            .padding([.leading, .trailing], 5).padding([.top, .bottom], 10)
            .background(Color(#colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)).cornerRadius(20)).padding([.leading, .trailing])
            .frame(height: UIScreen.main.bounds.width/1.75)
        }
    }
    
    private func graphBar(value: Int, text: String, isLast: Bool = false, weekly: Bool = true) -> some View {
        var maxTracked = manager.fastingModel.last7DaysTrackedSeconds.max()!
        if weekly == false { maxTracked = manager.fastingModel.thisMonthTrackedSeconds.max()! }
        return HStack {
            VStack(alignment: .center) {
                GeometryReader { reader in
                    VStack {
                        Spacer()
                        LinearGradient(gradient: barGradient, startPoint: .top, endPoint: .bottom)
                            .mask(RoundedRectangle(cornerRadius: 20))
                            .frame(height: value == 0 ? 0 : (CGFloat(value) * (reader.size.height - 10)) / CGFloat(maxTracked))
                    }
                }.frame(width: 20)
                Text(text).lineLimit(1).minimumScaleFactor(0.5).multilineTextAlignment(.center)
            }
            if !isLast { Spacer() }
        }
    }
}

struct HistoryTabView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTabView(manager: FastingDataManager())
    }
}

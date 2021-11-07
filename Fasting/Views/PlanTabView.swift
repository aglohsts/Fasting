//
//  PlanTabView.swift
//  Fasting
//
//  Created by Yu-chen chih on 2021/11/6.
//

import SwiftUI

struct PlanTabView: View {
    
    @ObservedObject var manager: FastingDataManager
    private let columns = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]
    
    var body: some View {
        ScrollView {
            Divider().padding()
            FastingPlansSection
        }
    }
    
    /// Fasting plans section
    private var FastingPlansSection: some View {
        VStack {
            Text("Fasting Plans").font(.title2).fontWeight(.medium)
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(FastingPlan.allCases, id: \.self, content: { plan in
                    Button(action: {
                        manager.currentFastingPlan = plan
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }, label: {
                        ZStack {
                            LinearGradient(gradient: plan.planGradient, startPoint: .top, endPoint: .bottom)
                                .mask(RoundedRectangle(cornerRadius: 20))
                            HStack {
                                VStack(alignment: .trailing) {
                                    Text(plan.rawValue).font(.system(size: 40)).bold().frame(height: 45)
                                    Text("fast").fontWeight(.light).opacity(0.5)
                                }.minimumScaleFactor(0.5)
                                Image(systemName: "clock").padding()
                                VStack(alignment: .trailing) {
                                    Text("\(24-Int(plan.rawValue)!)").font(.system(size: 30)).frame(height: 45)
                                    Text("eat").fontWeight(.light).opacity(0.5)
                                }
                            }.foregroundColor(.white).padding([.leading, .trailing])
                        }.frame(height: UIScreen.main.bounds.width / 4).opacity(plan != manager.currentFastingPlan ? 0.45 : 1.0)
                    })
                })
            }.padding()
        }
    }
}

struct PlanTabView_Previews: PreviewProvider {
    static var previews: some View {
        PlanTabView(manager: FastingDataManager())
    }
}

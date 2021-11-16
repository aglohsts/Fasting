//
//  PlanTabView.swift
//  Fasting
//
//  Created by lohsts on 2021/11/6.
//

import SwiftUI

struct PlanTabView: View {
    
    @ObservedObject var manager: FastingDataManager
    private let columns = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]
    
    var body: some View {
        ScrollView {
            Divider().padding()
            ForEach(Array(manager.planData.enumerated()), id: \.offset, content: { index, plan in
                PlanListItemView(manager: manager, plan: plan, index: index)
                    .padding([.leading, .trailing, .bottom])
            })
        }
    }
}

struct PlanTabView_Previews: PreviewProvider {
    static var previews: some View {
        PlanTabView(manager: FastingDataManager())
    }
}

//
//  PlanTabView.swift
//  Fasting
//
//  Created by Yu-chen chih on 2021/11/6.
//

import SwiftUI

struct PlanTabView: View {
    @ObservedObject var manager: FastingDataManager
    
    var body: some View {
        Text("Plan")
    }
}

struct PlanTabView_Previews: PreviewProvider {
    static var previews: some View {
        PlanTabView(manager: FastingDataManager())
    }
}

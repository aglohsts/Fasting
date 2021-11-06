//
//  RecipeTabView.swift
//  Fasting
//
//  Created by Yu-chen chih on 2021/11/1.
//

import SwiftUI

struct RecipeTabView: View {
    @ObservedObject var manager: FastingDataManager
    
    var body: some View {
        Text("Recipe")
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView(manager: FastingDataManager())
    }
}

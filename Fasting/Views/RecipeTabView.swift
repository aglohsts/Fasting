//
//  RecipeTabView.swift
//  Fasting
//
//  Created by lohsts on 2021/11/1.
//

import SwiftUI

struct RecipeTabView: View {
    @ObservedObject var manager: FastingDataManager
    
    
    var body: some View {
//        List {
        ScrollView {
            Divider()
                .padding()
            VStack {
                ForEach(manager.recipeData) { item in
                    RecipeListItemView(recipe: item)
                }
            }
        }
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView(manager: FastingDataManager())
    }
}

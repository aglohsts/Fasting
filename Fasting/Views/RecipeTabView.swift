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
        ScrollView {
            Divider()
                .padding()
            VStack {
                ForEach(Array(manager.recipeData.enumerated()), id: \.offset) { index, recipe in
                    NavigationLink(
                        destination: RecipeDetailContentView(manager: manager, recipe: recipe, index: index),
                        label: {
                            RecipeListItemView(manager: manager, recipe: recipe, index: index)
                        })
                        .isDetailLink(false)
//                        .navigationViewStyle(StackNavigationViewStyle())
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

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
                ForEach(manager.recipeData) { recipe in
                    NavigationLink(
                        destination: RecipeDetailContentView(recipe: recipe),
                        label: {
                            RecipeListItemView(recipe: recipe)
                        }).navigationTitle(recipe.title)
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

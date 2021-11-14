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
                ForEach(manager.recipeData) { item in
                    NavigationLink(
                        destination: Text("push view"),
                        label: {
                            RecipeListItemView(recipe: item)
                        }).navigationTitle("Title")
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

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
        List {
            ForEach(manager.recipeData) { item in
                RecipeListItemView(recipe: item)
                    .padding(.vertical, 8.0)
            }
        }
    }
}
    
class Recipe: ObservableObject, Identifiable {
    var id: String
    var image: String
    var title: String
    var description: String
    var note: String
    @Published var isFavorite: Bool = false
    
    init(id: String = UUID().uuidString, image: String, title: String, description: String, note: String) {
        self.id = id
        self.image = image
        self.title = title
        self.description = description
        self.note = note
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView(manager: FastingDataManager())
    }
}

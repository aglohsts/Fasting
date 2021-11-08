//
//  RecipeModel.swift
//  Fasting
//
//  Created by Yu-chen chih on 2021/11/8.
//

import Foundation

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

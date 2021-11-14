//
//  RecipeModel.swift
//  Fasting
//
//  Created by lohsts on 2021/11/8.
//

import Foundation
import SwiftUI

class Recipe: ObservableObject, Identifiable {
    var id: String
    var imageName: String
    var title: String
    var description: String
    var note: String
    var source: String
    var meal: Meal
    @Published var isFavorite: Bool = false
    
    init(id: String = UUID().uuidString, imageName: String, title: String, description: String, note: String, source: String, meal: Meal) {
        self.id = id
        self.imageName = imageName
        self.title = title
        self.description = description
        self.note = note
        self.source = source
        self.meal = meal
    }
    
    var image: Image {
        return Image(imageName)
    }
    
    enum Meal: String {
        case breakfast
        case lunchOrdinner = "Lunch or Dinner"
        case other
    }
}

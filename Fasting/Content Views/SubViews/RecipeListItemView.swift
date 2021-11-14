//
//  RecipeListItemView.swift
//  Fasting
//
//  Created by lohsts on 2021/11/7.
//

import SwiftUI

struct RecipeListItemView: View {
    @StateObject var recipe: Recipe

    var body: some View {
        HStack(alignment: .top, spacing: 12.0) {
            Image(recipe.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .background(Color.clear)
                .cornerRadius(10)
                .padding([.leading, .top, .bottom], 8)

            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(recipe.description)
                    .foregroundColor(.black)
                    .lineLimit(nil)
                    .lineSpacing(4)
                    .font(.subheadline)
                    .frame(height: 50.0)

                Text(recipe.note)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding([.top], 4)
                
            }
            .background(Color.clear)
            .padding([.top, .bottom], 10)
            
            VStack(alignment: .leading) {
                Button(action: {
                    recipe.isFavorite.toggle()
                }, label: {
                    recipe.isFavorite ? Image(systemName: "heart.fill").foregroundColor(.red) : Image(systemName: "heart").foregroundColor(.gray)
                })
                .background(Color.clear)
                .padding(8)
                
                Spacer()
            }
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding([.leading, .trailing], 10)
        .padding([.bottom], 8)
    }
}

struct RecipeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListItemView(recipe:Recipe(imageName: "recipe_grilled_lemon_salmon", title: "GRILLED LEMON SALMON", description: "Having lemon in the name of the recipe really threw me, but it was fantastic! I served it alongside pineapple rice and fresh green beans, making it a very satisfying meal!", note: "Protein", source: "https://www.food.com/recipe/grilled-lemon-salmon-30469", meal: .lunchOrdinner))
    }
}

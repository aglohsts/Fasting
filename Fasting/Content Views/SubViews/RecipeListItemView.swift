//
//  RecipeListItemView.swift
//  Fasting
//
//  Created by Yu-chen chih on 2021/11/7.
//

import SwiftUI

struct RecipeListItemView: View {
    @StateObject var recipe: Recipe

    var body: some View {
        HStack(spacing: 12.0) {
            Image(recipe.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 120, height: 120)
            .background(Color("background"))
            .cornerRadius(20)

            VStack(alignment: .leading) {
              Text(recipe.title)
                .font(.headline)

              Text(recipe.description)
                .lineLimit(2)
                .lineSpacing(4)
                .font(.subheadline)
                .frame(height: 50.0)

              Text(recipe.note)
                .font(.caption)
                .fontWeight(.bold)
            }
            .background(Color.clear)
            
            Button(action: {
                recipe.isFavorite = !recipe.isFavorite
            }, label: {
                recipe.isFavorite ? Image(systemName: "star.fill").foregroundColor(.orange) : Image(systemName: "star").foregroundColor(.gray)
            })
            .background(Color.clear)
            .padding()
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding([.leading, .trailing, .bottom], 10)
    }
}

struct RecipeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListItemView(recipe: Recipe(image: "icons8-apple-100", title: "Test", description: "testtesttest testtesttest testtesttest testtesttest testtesttest testtesttest", note: "note"))
    }
}

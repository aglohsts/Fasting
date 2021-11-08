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
        HStack(spacing: 12.0) {
            Image(recipe.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 120, height: 120)
            .background(Color.clear)
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
                .foregroundColor(.gray)
            }
            .background(Color.clear)
            
            VStack(alignment: .leading) {
                Button(action: {
                    recipe.isFavorite.toggle()
                }, label: {
                    recipe.isFavorite ? Image(systemName: "heart.fill").foregroundColor(.red) : Image(systemName: "heart").foregroundColor(.gray)
                })
                .background(Color.clear)
                .padding()
                
                Spacer()
            }
            
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

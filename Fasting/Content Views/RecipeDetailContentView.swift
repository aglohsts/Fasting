//
//  RecipeDetailContentView.swift
//  Fasting
//
//  Created by Yu-chen chih on 2021/11/14.
//

import SwiftUI
import EventKit

struct RecipeDetailContentView: View {
    
    @State var isAddingCalendar: Bool = false
    
    var recipe: Recipe
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10, content: {
                Text(recipe.title)
                    .font(.title)
                    .bold()
                    .padding([.top, .leading, .trailing], 20)
                
                VStack(alignment: .leading, spacing: 10, content: {
                    TagView(text: recipe.meal.rawValue.capitalized, textColor: .white, backgroundColor: .black)
                        .padding([.top, .leading, .trailing], 20)
                    
                    recipe.image
                        .resizable()
                        .cornerRadius(8)
                        .aspectRatio(contentMode: .fit)
                        .padding([.leading, .trailing], 20)
                        .padding([.top, .bottom], 10)

                    Text(recipe.description)
                        .font(.title2)
                        .padding([.leading, .trailing], 20)
                        .background(Color(#colorLiteral(red: 0.9408885837, green: 0.9492552876, blue: 0.9408323169, alpha: 1)))
                    
                    
                    Text(recipe.note)
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.gray)
                        .padding([.leading, .trailing], 20)
                        .padding([.top], 20)
                        .padding([.bottom], 30)
                        .background(Color(#colorLiteral(red: 0.9408885837, green: 0.9492552876, blue: 0.9408323169, alpha: 1)))
                })
                .background(Color(#colorLiteral(red: 0.9408885837, green: 0.9492552876, blue: 0.9408323169, alpha: 1)))
                .cornerRadius(10)
                .padding([.leading, .trailing, .bottom])
            })
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
            
            Button(action: {
                isAddingCalendar = true
            }, label: {
                Text("Sync with Calendar")
            })
            
            Spacer()
        }
        .sheet(isPresented: $isAddingCalendar, content: {
            EKEventWrapper(isShowing: $isAddingCalendar, eventTitle: recipe.title, eventLink: recipe.source)
        })
            
    }
}

struct RecipeDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailContentView(recipe: Recipe(imageName: "recipe_sabudana_khichdi", title: "Sabudana Khichdi", description: "Sabudana ki khichdi is a delicious dish of tapioca pearls (sago) made with potatoes, peanuts and usually had during Hindu fasting days like Navratri, Ekadashi, mahashivratri. It is also a gluten free recipe. In this recipe post, you will get many tips and suggestions to make the best non-sticky sabudana khichdi. ", note: "Bread & Grains", source: "https://www.vegrecipesofindia.com/navratri-recipes-navratri-fasting-recipes", meal: .lunchOrdinner))
    }
}

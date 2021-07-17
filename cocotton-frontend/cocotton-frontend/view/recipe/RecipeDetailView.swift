//
//  RecipeDetailView.swift
//  cocotton-frontend
//
//  Created by Developer on 15/07/2021.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe: Recipe
    @State private var ingredients = [Ingredient]()
    
    private let ingredientController: IngredientController = IngredientController()
    private let profileController: ProfileController = ProfileController()
    
    var body: some View {
        ScrollView { //scrollview 1
            Spacer()
                .frame(height: 135)
            
            CircleImageViewElement(image: Image("recipe_row_image"))
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) { // VStack 1
                Text(recipe.title!)
                    .font(.title)

                HStack {
                    Text("Added by: ")
                    Spacer()
                    Text(self.profileController.findProfileByIdFromSample(id: recipe.userId!)!.username!)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()

                Text("Ingredients for \(recipe.title!)")
                    .font(.title2)
                List(ingredients) { ingredient in
                    NavigationLink(destination: IngredientDetailView(ingredient: ingredient)) {
                        IngredientRowViewElement(ingredient: ingredient)
                    }
                }
                .frame(height: 200)
                .onAppear{
                    self.ingredients = ingredientController.findAllIngredientsOfARecipe(ingredientsId: recipe.ingredients!)
                    print(recipe)
                    print(ingredients)
                }
                
                Divider()

                Text("Steps for \(recipe.title!)")
                    .font(.title2)
                List(recipe.steps!, id: \.self) { step in
                    Text(step)
                }
                .frame(height: 200	)
            }// end VStack 1
            .padding()
            
        } // end scrollview 1
        .navigationTitle(recipe.title!)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe())
    }
}

//
//  RecipeListView.swift
//  cocotton-frontend
//
//  Created by Developer on 15/07/2021.
//

import SwiftUI

struct RecipeListView: View {
    
    @State  private var recipes = [Recipe]()
    
    private let recipeController: RecipeController = RecipeController()
    
    var body: some View {
        List(recipes) { recipe in
            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                RecipeRowViewElement(recipe: recipe, recipeNumber: recipes.firstIndex(of: recipe)!+1)
            }
        }
        .onAppear{
            self.recipes = recipeController.findRecipes()
        }
        .navigationTitle("Recipe list")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}

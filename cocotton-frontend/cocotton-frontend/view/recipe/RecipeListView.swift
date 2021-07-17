//
//  RecipeListView.swift
//  cocotton-frontend
//
//  Created by Developer on 15/07/2021.
//

import SwiftUI

struct RecipeListView: View {
    
    @State private var recipes = [Recipe]()
    
    private let recipeController: RecipeController = RecipeController()
    
    var body: some View {
        List(recipes) { recipe in
            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                RecipeRowViewElement(recipe: recipe)
            }
        }
        .onAppear{
            self.recipes = recipeController.loadRecipesFromJson()
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

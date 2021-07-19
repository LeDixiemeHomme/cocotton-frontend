//
//  RecipeRow.swift
//  cocotton-frontend
//
//  Created by Developer on 15/07/2021.
//

import SwiftUI

struct RecipeRowViewElement: View {
    public var recipe: Recipe
    public var recipeNumber: Int

    var body: some View {
        HStack {
            Image("recipe_row_image")
                .resizable()
                .frame(width: 50, height: 50)
            Text(" \(recipeNumber.description). \(recipe.title)")

            Spacer()
        }
    }
}

struct RecipeRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRowViewElement(recipe: Recipe(id: "", title: "", people: 1, ingredients: ["String"], steps: ["String"], userId: ""), recipeNumber: 0)
    }
}

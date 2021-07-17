//
//  RecipeController.swift
//  cocotton-frontend
//
//  Created by Developer on 17/07/2021.
//

import Foundation

let RECIPE_TARGET: String = "recipes/"

class RecipeController {
    
    let rest = RestManager()
    let recipeTarget = RECIPE_TARGET
    
    func loadRecipesFromJson() -> [Recipe] {
        return load("recipes")
    }
    
    func getRecipesCount() -> Int {
        return loadRecipesFromJson().count
    }
    
}

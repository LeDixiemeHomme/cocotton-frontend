//
//  IngredientController.swift
//  cocotton-frontend
//
//  Created by Developer on 17/07/2021.
//

import Foundation

let INGREDIENT_TARGET: String = "ingredients/"

class IngredientController {
    
    let rest = RestManager()
    let ingredientTarget = INGREDIENT_TARGET
    
    func loadIngredientsFromJson() -> [Ingredient] {
        return load("ingredients")
    }
    
    func findIngredientByIdFromSample(id: String) -> Ingredient? {
        let ingredients = loadIngredientsFromJson()
        for item in ingredients {
            if item.id == id {
                return item
            }
        }
        return nil
    }
    
    func findAllIngredientsOfARecipe(ingredientsId: [String]) -> [Ingredient] {
        var ingredients = [Ingredient]()
        
        for id in ingredientsId {
            if let ingre: Ingredient = findIngredientByIdFromSample(id: id){
                ingredients.append(ingre)
            }
        }
        return ingredients
    }
    
    func getIngredientsCount() -> Int {
        return loadIngredientsFromJson().count
    }
    
}

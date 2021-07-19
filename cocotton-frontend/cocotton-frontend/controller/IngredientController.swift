//
//  IngredientController.swift
//  cocotton-frontend
//
//  Created by Developer on 17/07/2021.
//

import Foundation
import SwiftKeychainWrapper

let INGREDIENT_TARGET: String = "api/ingredients/"

class IngredientController {
    
    let rest = RestManager()
    let ingredientTarget = INGREDIENT_TARGET
    
    func findIngredients() -> [Ingredient] {
        var ingredients: [Ingredient] = [Ingredient]()
        let semaphore = DispatchSemaphore(value: 0)
        
        guard let url = URL(string: API_BASE_URL + ingredientTarget) else { return ingredients }
        rest.makeRequest(toURL: url, withHttpMethod: .get, token: KeychainWrapper.standard[.tokenSession]!) { (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 200 {
                if let data = results.data {
                    let decoder = JSONDecoder()
                    if let fetchedIngredients: [Ingredient] = try? decoder.decode([Ingredient].self, from: data){
                        ingredients = fetchedIngredients
                    } else {
                        return
                    }
                }
            }
            semaphore.signal()
            return
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return ingredients
    }
    
    func getIngredientsCount() -> Int {
        return findIngredients().count
    }
    
    func findIngredientById(ingredientId: String) -> Ingredient? {
        var ingredient = Ingredient(id: "", name: "", category: "")
        let semaphore = DispatchSemaphore(value: 0)
        
        guard let url = URL(string: API_BASE_URL + ingredientTarget + ingredientId) else { return nil }
        rest.makeRequest(toURL: url, withHttpMethod: .get, token: KeychainWrapper.standard[.tokenSession]!) { (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 200 {
                if let data = results.data {
                    let decoder = JSONDecoder()
                    if let fetchedIngredient: Ingredient = try? decoder.decode(Ingredient.self, from: data){
                        ingredient.id = fetchedIngredient.id
                        ingredient.name = fetchedIngredient.name
                        ingredient.category = fetchedIngredient.category
                    } else {
                        return
                    }
                }
            }
            semaphore.signal()
            return
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        if ingredient.id == "" {
            return nil
        } else {
            return ingredient
        }
    }
    
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
            if let ingre: Ingredient = findIngredientById(ingredientId: id){
                ingredients.append(ingre)
            }
        }
        return ingredients
    }
    
//    func getIngredientsCount() -> Int {
//        return loadIngredientsFromJson().count
//    }
    
}

//
//  RecipeController.swift
//  cocotton-frontend
//
//  Created by Developer on 17/07/2021.
//

import Foundation
import SwiftKeychainWrapper

let RECIPE_TARGET: String = "api/recipes/"

class RecipeController {
    
    let rest = RestManager()
    let recipeTarget = RECIPE_TARGET
    
    func findRecipes() -> [Recipe] {
        var recipes: [Recipe] = [Recipe]()
        let semaphore = DispatchSemaphore(value: 0)
        
        guard let url = URL(string: API_BASE_URL + recipeTarget) else { return recipes }
        rest.makeRequest(toURL: url, withHttpMethod: .get, token: KeychainWrapper.standard[.tokenSession]!) { (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 200 {
                if let data = results.data {
                    let decoder = JSONDecoder()
                    if let fetchedRecipes: [Recipe] = try? decoder.decode([Recipe].self, from: data){
                        recipes = fetchedRecipes
                    } else {
                        return
                    }
                }
            }
            semaphore.signal()
            return
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return recipes
    }
    
    func getRecipesCount() -> Int {
        return findRecipes().count
    }
    
    func loadRecipesFromJson() -> [Recipe] {
        return load("recipes")
    }
    
//    func getRecipesCount() -> Int {
//        return loadRecipesFromJson().count
//    }
    
}

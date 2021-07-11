//
//  Ingredient.swift
//  cocotton-frontend
//
//  Created by Developer on 27/06/2021.
//

import Foundation
	
struct Ingredient: Codable  {
    var id: String?
    var name: String?
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    func getIngredientById(id: String){
        
    }
    
}

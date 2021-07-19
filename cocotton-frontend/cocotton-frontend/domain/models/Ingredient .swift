//
//  Ingredient.swift
//  cocotton-frontend
//
//  Created by Developer on 27/06/2021.
//

import Foundation
	
struct Ingredient: Codable, Identifiable {
    var id: String
    var name: String
    var category: String
    
    init(id: String, name: String, category: String){
        self.id = id
        self.name = name
        self.category = category
    }
}

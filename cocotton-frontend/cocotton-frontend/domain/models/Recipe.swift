//
//  Recipe.swift
//  cocotton-frontend
//
//  Created by Developer on 29/06/2021.
//

import Foundation

struct Recipe: Hashable, Codable, Identifiable {
    var id: String
    var title: String
    var people: Int
    var ingredients: [String]
    var steps: [String]
    var userId: String
    
    init(id: String, title: String, people: Int, ingredients: [String], steps: [String], userId: String){
        self.id = id
        self.title = title
        self.people = people
        self.ingredients = ingredients
        self.steps = steps
        self.userId = userId
    }
}

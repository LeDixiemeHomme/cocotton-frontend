//
//  Recipe.swift
//  cocotton-frontend
//
//  Created by Developer on 29/06/2021.
//

import Foundation

struct Recipe: Codable  {
    var id: String?
    var name: String?
    var ingredients: [Ingredient]?
    var profileId: String?
    var steps: [String]?
}

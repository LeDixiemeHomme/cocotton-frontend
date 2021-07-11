//
//  Recipe.swift
//  cocotton-frontend
//
//  Created by Developer on 29/06/2021.
//

import Foundation

struct Recipe: Codable  {
    let id: String?
    let name: String?
    let ingredients: [Ingredient]?
    let profileId: String?
    let steps: [String]?
}

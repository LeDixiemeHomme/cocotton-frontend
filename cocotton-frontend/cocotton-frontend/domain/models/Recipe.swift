//
//  Recipe.swift
//  cocotton-frontend
//
//  Created by Developer on 29/06/2021.
//

import Foundation

struct Recipe: Hashable, Codable, Identifiable {
    var id: String?
    var title: String?
    var people: Int?
    var ingredients: [String]?
    var steps: [String]?
    var userId: String?
}

struct Steps : Hashable, Codable {
    var steps: [String]?
}

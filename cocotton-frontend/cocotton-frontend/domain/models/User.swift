//
//  User.swift
//  cocotton-frontend
//
//  Created by Developer on 09/07/2021.
//

import Foundation

struct User: Codable  {
let id: String
let lastName: String

    init(id: String, lastName: String) {
        self.id = id
        self.lastName = lastName
    }

}

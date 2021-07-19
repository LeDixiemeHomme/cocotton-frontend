//
//  Profile.swift
//  cocotton-frontend
//
//  Created by Developer on 29/06/2021.
//

import Foundation

struct Profile: Codable  {
    var id: String
    var lastName: String
    var firstName: String
    var username: String
    var email: String
    var birthDate: String
    var adult: Bool

    init(id: String, lastName: String, firstName: String, email: String, username: String, birthDate: String){
        self.id = id
        self.lastName = lastName
        self.firstName = firstName
        self.email = email
        self.username = username
        self.birthDate = birthDate
        self.adult = false
    }
}

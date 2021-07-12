//
//  Profile.swift
//  cocotton-frontend
//
//  Created by Developer on 29/06/2021.
//

import Foundation

struct Profile: Codable  {
    var id: String?
    var lastName: String?
    var firstName: String?
    var username: String?
    var email: String?
    var password: String?
    var birthDate: String?
    
    init(lastName: String, firstName: String, email: String, username: String, password: String, birthDate: String){
        self.lastName = lastName
        self.firstName = firstName
        self.email = email
        self.username = username
        self.password = password
        self.birthDate = birthDate
    }
    
}

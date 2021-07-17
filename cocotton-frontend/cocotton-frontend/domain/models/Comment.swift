//
//  Comment.swift
//  cocotton-frontend
//
//  Created by Developer on 29/06/2021.
//

import Foundation

struct Comment: Codable, Identifiable {
    var id: String?
    var content: String?
    var userId: String?
    
    mutating func setUserId(id: String) {
        self.userId = id
    }
}

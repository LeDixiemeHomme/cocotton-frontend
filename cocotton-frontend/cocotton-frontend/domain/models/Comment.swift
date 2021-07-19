//
//  Comment.swift
//  cocotton-frontend
//
//  Created by Developer on 29/06/2021.
//

import Foundation

struct Comment: Codable, Identifiable {
    var id: String
    var content: String
    var userId: String
    
    init(id: String, content: String, userId: String) {
        self.id = id
        self.content = content
        self.userId = userId
    }
}

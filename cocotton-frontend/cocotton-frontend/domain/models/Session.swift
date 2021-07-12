//
//  Session.swift
//  cocotton-frontend
//
//  Created by Developer on 29/06/2021.
//

import Foundation

struct Session: Codable {
    var id: String?
    var createdAt: Date?
    var token: String?
    var userId: String?
}

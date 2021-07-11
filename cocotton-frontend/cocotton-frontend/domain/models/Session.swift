//
//  Session.swift
//  cocotton-frontend
//
//  Created by Developer on 29/06/2021.
//

import Foundation

struct Session: Codable {
    let id: String?
    let createdAt: Date?
    let token: String?
    let userId: String?
}

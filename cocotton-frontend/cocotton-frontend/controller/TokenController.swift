//
//  TokenController.swift
//  cocotton-frontend
//
//  Created by Developer on 14/07/2021.
//

import Foundation
import SwiftKeychainWrapper

class TokenController {
    
    private let profileController: ProfileController = ProfileController()
    
    func testToken() -> Bool {
        if let tokenSession: String = KeychainWrapper.standard[.tokenSession] {
            if let _: Profile = profileController.findProfileByToken(token: tokenSession) {
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
    
}

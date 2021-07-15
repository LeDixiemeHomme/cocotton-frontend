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
    
    func isTokenWrapped() -> Bool {
        if let _: String = KeychainWrapper.standard[.tokenSession] {
            return true
        } else {
            return false
        }
    }
    
    func isWorkingToken() -> Bool {
        if let tokenSession: String = KeychainWrapper.standard[.tokenSession] {
            if let _: Profile = profileController.findProfileByToken(token: tokenSession) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
}

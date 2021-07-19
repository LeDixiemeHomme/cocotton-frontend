//
//  TokenController.swift
//  cocotton-frontend
//
//  Created by Developer on 14/07/2021.
//

import Foundation
import SwiftKeychainWrapper
import JWTDecode

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
        if let token: String = KeychainWrapper.standard[.tokenSession] {
            if let profileId: String = try? tokenToProfileId(token: token) {
                if let _: Profile = profileController.findProfileById(profileId: profileId) {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        }
        return false
    }
    
    func tokenToProfileId(token: String) throws -> String? {
        do {
            let jwt = try decode(jwt: token)
            let claim: Claim = jwt.claim(name: "sub")
            guard let profileId: String = claim.string else { return nil }
            return profileId
        }   catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
}

//
//  cocotton_frontendApp.swift
//  cocotton-frontend
//
//  Created by Developer on 27/06/2021.
//

import SwiftUI
import SwiftKeychainWrapper

@main
struct cocotton_frontendApp: App {
    
    @State private var shouldLogin = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                if shouldLogin {
                    NavigationView{
                        LoginView()
                    }
                } else {
                    InitialTabView()
                }
            }.onAppear{
                shouldLogin = TokenController().testToken()
            }
        }
    }
}

extension KeychainWrapper.Key {
    static let tokenSession: KeychainWrapper.Key = "tokenSession"
    static let profileId: KeychainWrapper.Key = "profileId"
    static let lastName: KeychainWrapper.Key = "lastName"
    static let firstName: KeychainWrapper.Key = "firstName"
    static let username: KeychainWrapper.Key = "username"
    static let email: KeychainWrapper.Key = "email"
    static let birthDate: KeychainWrapper.Key = "birthDate"
}

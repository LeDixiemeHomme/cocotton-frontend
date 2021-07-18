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
            NavigationView { // NavigationView 1
                InitialTabView(tabSelection: 3)
            } // end NavigationView 1
            .onAppear(perform: {
                print("appear cocotton_frontendApp")
                clearToken()
            })
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    func clearToken() {
//        KeychainWrapper.standard.remove(forKey: .tokenSession)
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

struct cocotton_frontendApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

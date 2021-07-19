//
//  AuthController.swift
//  cocotton-frontend
//
//  Created by Developer on 11/07/2021.
//

import Foundation

let AUTH_TARGET: String = "auth/"

class AuthController {
    
    let rest = RestManager()
    let authTarget = AUTH_TARGET
    
    func register(registerCredential: RegisterCredential) -> String? {
        var profile_id: String?
        let semaphore = DispatchSemaphore(value: 0)
        
        rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        rest.httpBodyParameters.add(value: registerCredential.firstName, forKey: "firstName")
        rest.httpBodyParameters.add(value: registerCredential.lastName, forKey: "lastName")
        rest.httpBodyParameters.add(value: registerCredential.email, forKey: "email")
        rest.httpBodyParameters.add(value: registerCredential.username, forKey: "username")
        rest.httpBodyParameters.add(value: registerCredential.birthDate, forKey: "birthDate")
        rest.httpBodyParameters.add(value: registerCredential.password, forKey: "password")
        
        guard let url = URL(string: API_BASE_URL + AUTH_TARGET + "register") else { return nil }
        
        rest.makeRequest(toURL: url, withHttpMethod: .post, token: "no_token") { (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 201 {
                guard let location: String = response.headers.value(forKey: "Location") else { return }
                profile_id = location.replacingOccurrences(of: "/profiles/", with: "")
                semaphore.signal()
            } else {
                semaphore.signal()
            }
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return profile_id
    }
    
    func login(loginCredential: LoginCredential) -> String? {
        var responseToken: String?
        let semaphore = DispatchSemaphore(value: 0)
        
        rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        rest.httpBodyParameters.add(value: loginCredential.username, forKey: "username")
        rest.httpBodyParameters.add(value: loginCredential.password, forKey: "password")

        guard let url = URL(string: API_BASE_URL + AUTH_TARGET + "login") else { return nil }
        
        rest.makeRequest(toURL: url, withHttpMethod: .post, token: nil) { (results) in
            
            guard let response = results.response else { return }
            if response.httpStatusCode == 201 {
                if results.data != nil {
                    guard let authorization: String = response.headers.value(forKey: "Authorization") else {
                        semaphore.signal()
                        return
                    }
                    responseToken = authorization.replacingOccurrences(of: "Bearer ", with: "")
                    semaphore.signal()
                }
            } else {
                semaphore.signal()
            }
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return responseToken
    }
}

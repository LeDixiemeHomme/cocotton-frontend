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
    
    func register(profile: Profile) -> String? {
        var profile_id: String = ""
        
        rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        rest.httpBodyParameters.add(value: profile.firstName!, forKey: "firstName")
        rest.httpBodyParameters.add(value: profile.lastName!, forKey: "lastName")
        rest.httpBodyParameters.add(value: profile.email!, forKey: "email")
        rest.httpBodyParameters.add(value: profile.username!, forKey: "username")
        rest.httpBodyParameters.add(value: profile.password!, forKey: "password")
        rest.httpBodyParameters.add(value: profile.birthDate!, forKey: "birthDate")
        
        guard let url = URL(string: API_BASE_URL + AUTH_TARGET + "register") else { return nil }
        
        rest.makeRequest(toURL: url, withHttpMethod: .post, token: "no_token") { (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 201 {
                guard let location: String = response.headers.value(forKey: "Location") else { return }
                profile_id = location
            }
        }
        
        return profile_id
    }
    
    func login(loginCredential: LoginCredential) -> String? {
        var responseToken: String? = nil
        let semaphore = DispatchSemaphore(value: 0)
        
        rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        rest.httpBodyParameters.add(value: loginCredential.username, forKey: "email")
        rest.httpBodyParameters.add(value: loginCredential.password, forKey: "password")
        
        guard let url = URL(string: API_BASE_URL + AUTH_TARGET + "login") else { return nil }
        rest.makeRequest(toURL: url, withHttpMethod: .post, token: nil) { (results) in
            
            guard let response = results.response else { return }
            if response.httpStatusCode == 200 {
                if let data = results.data {
                    
//                    guard let authorization: String = response.headers.value(forKey: "Authorization") else {
//                        semaphore.signal()
//                        return
//                    }
//                    responseToken = authorization
//                    semaphore.signal()
                    
                    let decoder = JSONDecoder()
                    if let uptoken: UPToken = try? decoder.decode(UPToken.self, from: data){
                        responseToken = uptoken.token
                    } else { return }
                    semaphore.signal()
                }
            }
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return responseToken
    }
}

//
//  ProfileController.swift
//  cocotton-frontend
//
//  Created by Developer on 13/07/2021.
//

import Foundation

let PROFILE_TARGET: String = "profiles/"

class ProfileController {
    
    let rest = RestManager()
    let profileTarget = PROFILE_TARGET
    
    func findProfileByToken(token: String) -> Profile? {
        var profile: Profile? = nil
        let semaphore = DispatchSemaphore(value: 0)
        rest.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        
        guard let url = URL(string: API_BASE_URL + PROFILE_TARGET + "token") else { return nil }
        rest.makeRequest(toURL: url, withHttpMethod: .post, token: nil) { (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 200 {
                if let data = results.data {
                    let decoder = JSONDecoder()
                    if let fetchedProfile: Profile = try? decoder.decode(Profile.self, from: data){
                        profile?.username = fetchedProfile.username
                        profile?.lastName = fetchedProfile.lastName
                        profile?.firstName = fetchedProfile.firstName
                        profile?.birthDate = fetchedProfile.birthDate
                    } else { return }
                    semaphore.signal()
                }
            }
        
        }
        
        return profile
    }
    
}

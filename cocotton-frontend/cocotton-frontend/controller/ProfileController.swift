//
//  ProfileController.swift
//  cocotton-frontend
//
//  Created by Developer on 13/07/2021.
//

import Foundation
import JWTDecode
import SwiftKeychainWrapper

let PROFILE_TARGET: String = "api/profiles/"

class ProfileController {
    
    let rest = RestManager()
    let profileTarget = PROFILE_TARGET
    
    func findProfileById(profileId: String) -> Profile? {
        var profile = Profile(id: "", lastName: "", firstName: "", email: "", username: "", birthDate: "")
        let semaphore = DispatchSemaphore(value: 0)
        
        guard let url = URL(string: API_BASE_URL + profileTarget + profileId) else { return nil }
        rest.makeRequest(toURL: url, withHttpMethod: .get, token: KeychainWrapper.standard[.tokenSession]!) { (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 200 {
                if let data = results.data {
                    let decoder = JSONDecoder()
                    if let fetchedProfile: Profile = try? decoder.decode(Profile.self, from: data){
                        profile.id = fetchedProfile.id
                        profile.username = fetchedProfile.username
                        profile.lastName = fetchedProfile.lastName
                        profile.email = fetchedProfile.email
                        profile.firstName = fetchedProfile.firstName
                        profile.birthDate = fetchedProfile.birthDate
                    } else {
                        return
                    }
                }
            }
            semaphore.signal()
            return
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        if profile.id == "" {
            return nil
        } else {
            return profile
        }
    }
    
    func findProfileCount() -> [Profile] {
        var profiles: [Profile] = [Profile]()
        let semaphore = DispatchSemaphore(value: 0)
        
        guard let url = URL(string: API_BASE_URL + profileTarget) else { return profiles }
        rest.makeRequest(toURL: url, withHttpMethod: .get, token: KeychainWrapper.standard[.tokenSession]!) { (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 200 {
                if let data = results.data {
                    let decoder = JSONDecoder()
                    if let fetchedProfiles: [Profile] = try? decoder.decode([Profile].self	, from: data){
                        profiles = fetchedProfiles
                    } else {
                        return
                    }
                }
            }
            semaphore.signal()
            return
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return profiles
    }
    
    func getProfilesCount() -> Int {
        return findProfileCount().count
    }
    
    func loadProfilesFromJson() -> [Profile] {
        return load("profiles")
    }
    
    func findProfileByIdFromSample(id: String) -> Profile? {
        let profiles = loadProfilesFromJson()
        for item in profiles {
            if item.id == id {
                return item
            }
        }
        return nil
    }
    
//    func getProfilesCount() -> Int {
//        return loadProfilesFromJson().count
//    }
}

//
//  CommentController.swift
//  cocotton-frontend
//
//  Created by Developer on 17/07/2021.
//

import Foundation
import SwiftKeychainWrapper

let COMMENT_TARGET: String = "api/comments/"

class CommentController {
    
    let rest = RestManager()
    let commentTarget = COMMENT_TARGET
    
    func findComments() -> [Comment] {
        var comments: [Comment] = [Comment]()
        let semaphore = DispatchSemaphore(value: 0)
        
        guard let url = URL(string: API_BASE_URL + commentTarget) else { return comments }
        rest.makeRequest(toURL: url, withHttpMethod: .get, token: KeychainWrapper.standard[.tokenSession]!) { (results) in
            guard let response = results.response else { return }
            if response.httpStatusCode == 200 {
                if let data = results.data {
                    let decoder = JSONDecoder()
                    if let fetchedComments: [Comment] = try? decoder.decode([Comment].self, from: data){
                        comments = fetchedComments
                    } else {
                        return
                    }
                }
            }
            semaphore.signal()
            return
        }
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return comments
    }
    
    func getCommentsCount() -> Int {
        return findComments().count
    }
    
    func loadCommentsFromJson() -> [Comment] {
        return load("comments")
    }
    
//    func getCommentsCount() -> Int {
//        return loadCommentsFromJson().count
//    }
}

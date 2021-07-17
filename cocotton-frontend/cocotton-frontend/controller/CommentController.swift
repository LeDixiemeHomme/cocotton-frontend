//
//  CommentController.swift
//  cocotton-frontend
//
//  Created by Developer on 17/07/2021.
//

import Foundation

let COMMENT_TARGET: String = "comments/"

class CommentController {
    
    let rest = RestManager()
    let profileTarget = PROFILE_TARGET
    
    func loadCommentsFromJson() -> [Comment] {
        return load("comments")
    }
    
    func getCommentsCount() -> Int {
        return loadCommentsFromJson().count
    }
    
}

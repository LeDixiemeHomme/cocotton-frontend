//
//  CommentRowViewElement.swift
//  cocotton-frontend
//
//  Created by Developer on 17/07/2021.
//

import SwiftUI

struct CommentRowViewElement: View {
    public var comment: Comment
    private let profileController: ProfileController = ProfileController()

    var body: some View {
        HStack {
            VStack {
                if let unwrappedId = self.profileController.findProfileById(profileId: comment.userId)!.username {
                    Text(unwrappedId)
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    Text("Err")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                Text(comment.content)
                    .font(.system(size: 22))
                    .padding(.leading, 3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct CommentRowViewElement_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowViewElement(comment: Comment(id: "String", content: "String", userId: "String"))
    }
}

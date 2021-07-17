//
//  CommentListView.swift
//  cocotton-frontend
//
//  Created by Developer on 17/07/2021.
//
	
import SwiftUI

struct CommentListView: View {
    
    @State private var comments = [Comment]()
    
    private let commentController: CommentController = CommentController()
    
    var body: some View {
        VStack {
            Text("All comments about the Cocotton App")
                .foregroundColor(.white)
            
            List(comments) { comment in
                CommentRowViewElement(comment: comment)
            }
            .frame(height: 300)
            .onAppear{
                self.comments = commentController.loadCommentsFromJson()
            }
        }
        .padding(.vertical)
        .background(Color.black.opacity(0.5))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

struct CommentListView_Previews: PreviewProvider {
    static var previews: some View {
        CommentListView()
    }
}

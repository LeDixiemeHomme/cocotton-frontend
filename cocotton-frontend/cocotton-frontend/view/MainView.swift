//
//  MainView.swift
//  cocotton-frontend
//
//  Created by Developer on 11/07/2021.
//

import SwiftUI

struct MainView: View {
    
    @State private var shouldLogin = false
    
    @State private var comments = [Comment]()
    
    private let commentController: CommentController = CommentController()
    
    private let backGround: String = "main_background"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) { // VStack 1
                Spacer()
                HStack {
                Text("Cocotton")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                }
                
                Spacer()
                
                CommentListView()
                
                Spacer()
                
                StatsView()
                
                Spacer()
            }// end VStack 1
        }
        .background(
            Image(self.backGround)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 2)
        )
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//
//  MainView.swift
//  cocotton-frontend
//
//  Created by Developer on 11/07/2021.
//

import SwiftUI

struct MainView: View {
    
    @State private var shouldLogin = false
    
    private let backGround: String = "main_background"
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            Text("Cocotton")
                .font(.system(size: 48, weight: .semibold))
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(8)
            Spacer()
        }
        .background(
            Image(self.backGround)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 2)
        )
//        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            print("appear MainView")
        })
        .onDisappear(perform: {
            print("disappear MainView")
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Main").font(.headline)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

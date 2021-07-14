//
//  MainView.swift
//  cocotton-frontend
//
//  Created by Developer on 11/07/2021.
//

import SwiftUI

struct MainView: View {
    
    @State private var shouldLogin = false
    
    var body: some View {
        VStack {
            Text("Cocotton")
                .font(.system(size: 64, weight: .semibold))
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(8)
            Text("Cocotton")
                .font(.system(size: 64, weight: .semibold))
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(8)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//
//  InitialTabView.swift
//  cocotton-frontend
//
//  Created by Developer on 14/07/2021.
//

import SwiftUI

struct InitialTabView: View {
    
    @State private var shouldLogin = false
    
    var body: some View {
        TabView {
            Text("view1").tabItem {
                Label("Playlist", systemImage: "play.rectangle.fill")}
            MainView().tabItem {
                Text("MainView")
                Image(systemName: "m.circle")}
            Text("view2").tabItem {
                Text("view2")
                Image(systemName: "m.circle")}
        }.onAppear{
            print(shouldLogin.description)
            shouldLogin = TokenController().testToken()
            print(shouldLogin.description)
        }
    }
}

struct InitialTabView_Previews: PreviewProvider {
    static var previews: some View {
        InitialTabView()
    }
}

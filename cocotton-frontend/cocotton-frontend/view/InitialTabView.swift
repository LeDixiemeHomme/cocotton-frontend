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
        if shouldLogin {
            LoginView().navigationBarBackButtonHidden(true)
        } else {
            TabView {
                MainView().tabItem {
                    Label("Recipes", systemImage: "list.dash")}
                MainView().tabItem {
                    Label("Add Recipe", systemImage: "note.text.badge.plus")}
                MainView().tabItem {
                    Label("Main Page", systemImage: "m.square.fill")}
                MainView().tabItem {
                    Label("Settings", systemImage: "gearshape.fill")}
            }.onAppear{
                print("gestion du passage par le login ici")
//                shouldLogin = !TokenController().isWorkingToken()
                shouldLogin = !TokenController().isTokenWrapped()
            }
        }
    }
}

struct InitialTabView_Previews: PreviewProvider {
    static var previews: some View {
        InitialTabView()
    }
}
	

//
//  InitialTabView.swift
//  cocotton-frontend
//
//  Created by Developer on 14/07/2021.
//

import SwiftUI

struct InitialTabView: View {
    
    @State private var shouldLogin = false
    @State var tabSelection: Int = 3
    
    var body: some View {
            VStack { // VStack 1
                if shouldLogin {
                    NavigationLink(
                        destination: LoginView().navigationBarBackButtonHidden(true),
                        isActive: $shouldLogin,
                        label: {})
                } else {
                    TabView (selection: $tabSelection){
                        RecipeListView().tabItem {
                            Label("Recipes", systemImage: "list.dash")}.tag(1)
                        MainView().tabItem {
                            Label("Add Recipe", systemImage: "note.text.badge.plus")}.tag(2)
                        MainView().tabItem {
                            Label("Main Page", systemImage: "m.square")}.tag(3)
                        MainView().tabItem {
                            Label("Settings", systemImage: "gearshape.fill")}.tag(4)
                    }
                }
            } // end VStack 1
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Title").font(.headline)
                }
            }
            .onAppear{
                print("appear InitialTabView")
                print("gestion du passage par le login ici")
    //                shouldLogin = !TokenController().isWorkingToken()
                shouldLogin = !TokenController().isTokenWrapped()
                print("\"" + shouldLogin.description + "\" après le test de la présence du token")
            }.onDisappear(perform: {
                print("disappear InitialTabView")
            })
    }
}

struct InitialTabView_Previews: PreviewProvider {
    static var previews: some View {
        InitialTabView()
    }
}
	

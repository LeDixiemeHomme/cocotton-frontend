//
//  InitialTabView.swift
//  cocotton-frontend
//
//  Created by Developer on 14/07/2021.
//

import SwiftUI
import JWTDecode

struct InitialTabView: View {
    
    @State private var shouldLogin = false
    @State var tabSelection: Int
    
    private let backGround: String = "main_background"
    
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
                            Label("Main Page", systemImage: "m.square")}.tag(2)
                        RecipeCreateView().tabItem {
                            Label("Add Recipe", systemImage: "note.text.badge.plus")}.tag(3)
                        ProfileDetailView().tabItem {
                            Label("User Info", systemImage: "person.fill")}.tag(4)
                    }
                    .onAppear() {
                        UITabBar.appearance().backgroundColor = .blue
                    }
                }
            } // end VStack 1
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    switch tabSelection{
                    case 1:
                        Text("Recipe list").font(.	headline)
                    case 2:
                        Text("Main page").font(.headline)
                    case 3:
                        Text("Add recipe (Work in progress ...)").font(.headline)
                    case 4:
                        Text("User info").font(.headline)
                    default:
                        Text("Err").font(.headline)
                    }
                }
            }
            .onAppear{
                shouldLogin = !TokenController().isWorkingToken()
            }
    }
    
}

extension UITabBarController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let standardAppearance = UITabBarAppearance()

//        standardAppearance.backgroundImage = UIImage(named: "main_background")

        tabBar.standardAppearance = standardAppearance
    }
}

struct InitialTabView_Previews: PreviewProvider {
    static var previews: some View {
        InitialTabView(tabSelection: 2)
    }
}
	

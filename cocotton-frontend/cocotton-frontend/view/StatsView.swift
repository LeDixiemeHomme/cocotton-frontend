//
//  StatsView.swift
//  cocotton-frontend
//
//  Created by Developer on 17/07/2021.
//

import SwiftUI

struct StatsView: View {
    
    let commentController: CommentController = CommentController()
    let recipeController: RecipeController = RecipeController()
    let profileController: ProfileController = ProfileController()
    let ingredientController: IngredientController = IngredientController()
    
    @State private var commentCount: Int = 0
    @State private var recipeCount: Int = 0
    @State private var profileCount: Int = 0
    @State private var ingredientCount: Int = 0
    
    var body: some View {
        VStack {
            Text("Cocotton App stats")
                .foregroundColor(.white)
            
            List {
                HStack {
                    Text(self.profileCount.description + " profiles")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Divider()
                    Text(self.commentCount.description + " comments")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                HStack {
                    Text(self.recipeCount.description + " recipes")
                        .frame(maxWidth: .infinity, alignment: .center)
                    Divider()
                    Text(self.ingredientCount.description + " ingredients")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .frame(height: 90)
            .onAppear{
                self.commentCount = commentController.getCommentsCount()
                self.recipeCount = recipeController.getRecipesCount()
                self.profileCount = profileController.getProfilesCount()
                self.ingredientCount = ingredientController.getIngredientsCount()
            }
        }
        .padding(.vertical)
        .background(Color.black.opacity(0.5))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}

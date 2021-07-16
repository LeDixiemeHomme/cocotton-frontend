//
//  RecipeRow.swift
//  cocotton-frontend
//
//  Created by Developer on 15/07/2021.
//

import SwiftUI

struct RecipeRowViewElement: View {
    public var recipe: Recipe?

    var body: some View {
        HStack {
            Image("recipe_row_image")
                .resizable()
                .frame(width: 50, height: 50)
            Text(recipe!.name!)

            Spacer()
        }
    }
}

struct RecipeRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRowViewElement(recipe: nil)
    }
}

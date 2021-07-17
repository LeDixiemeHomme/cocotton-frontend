//
//  IngredientRowViewElement.swift
//  cocotton-frontend
//
//  Created by Developer on 17/07/2021.
//

import SwiftUI

struct IngredientRowViewElement: View {
    public var ingredient: Ingredient
    
    var body: some View {
        HStack {
            Image("ingredient_row_image")
                .resizable()
                .frame(width: 50, height: 50)
            Text(ingredient.name!)
            Text(ingredient.category!)

            Spacer()
        }
    }
}

struct IngredientRowViewElement_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRowViewElement(ingredient: Ingredient())
    }
}

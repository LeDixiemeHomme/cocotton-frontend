//
//  IngredientDetailView.swift
//  cocotton-frontend
//
//  Created by Developer on 17/07/2021.
//

import SwiftUI

struct IngredientDetailView: View {
    
    var ingredient: Ingredient
    
    var body: some View {
        ScrollView { //scrollview 1
            Spacer()
                .frame(height: 135)
            
            CircleImageViewElement(image: Image("ingredient_row_image"))
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) { // VStack 1
                Text(ingredient.name!)
                    .font(.title)

                HStack {
                    Text(ingredient.category!)
                    Spacer()
                    Text("")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }// end VStack 1
            .padding()
        }
    }
}

struct IngredientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientDetailView(ingredient: Ingredient())
    }
}

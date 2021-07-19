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
            
            HStack(alignment: .top) { // VStack 1
                Text(ingredient.name.capitalizingFirstLetter())
                    .font(.title)

                HStack {
                    switch ingredient.category{
                    case "MEAT":
                        Text(ingredient.category)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.red.opacity(0.5))
                            .cornerRadius(8)
                    case "VEGETABLE":
                        Text(ingredient.category)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.green.opacity(0.5))
                            .cornerRadius(8)
                    case "FRUIT":
                        Text(ingredient.category)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.orange.opacity(0.5))
                            .cornerRadius(8)
                    case "SPICE":
                        Text(ingredient.category)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(8)
                    case "OIL":
                        Text(ingredient.category)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.yellow.opacity(0.5))
                            .cornerRadius(8)
                    case "OTHER":
                        Text(ingredient.category)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(8)
                    default:
                        Text("Err")
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Text("")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }// end VStack 1
            .padding()
            .navigationTitle(ingredient.name.capitalizingFirstLetter())
            .navigationBarTitleDisplayMode(.inline)        }
    }
}

struct IngredientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientDetailView(ingredient: Ingredient(id: "", name: "garlic", category: "SPICE"))
    }
}

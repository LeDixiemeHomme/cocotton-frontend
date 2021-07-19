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
            Text(ingredient.name.capitalizingFirstLetter())
                
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
        }
    }
    
}

struct IngredientRowViewElement_Previews: PreviewProvider {
    static var previews: some View {
        IngredientRowViewElement(ingredient: Ingredient(id: "1", name: "egg", category: "MEAT"))
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

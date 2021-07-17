//
//  CircleImageViewElement.swift
//  cocotton-frontend
//
//  Created by Developer on 15/07/2021.
//

import SwiftUI

struct CircleImageViewElement: View {
    var image: Image

    var body: some View {
        image
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
    }
}

struct CircleImageViewElement_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageViewElement(image: Image("recipe_row_image"))
    }
}

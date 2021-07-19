//
//  RecipeCreateView.swift
//  cocotton-frontend
//
//  Created by Developer on 19/07/2021.
//

import SwiftUI

struct RecipeCreateView: View {
    
    private let backGround: String = "add_background"
    @State private var displayAlert = false
    @State private var alert: Alert = Alert(title: Text("Empty alert"))
    
    var body: some View {
        VStack {
            Spacer()
            Text("Work in progress ...")
                .font(.system(size: 48, weight: .semibold))
                .foregroundColor(.white)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(Color.black.opacity(0.5))
                .cornerRadius(8)
            Spacer()
        }
        .background(
            Image(self.backGround)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 2)
        ).edgesIgnoringSafeArea(.all)
        .alert(isPresented: $displayAlert, content: {
            self.alert
        })
        .onAppear{
            alert = Alert(
                title: Text("Coming soon"),
                message: Text("You will be able to create recipe on this page !")
            )
            self.displayAlert = true
        }
    }
}

struct RecipeCreateView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCreateView()
    }
}

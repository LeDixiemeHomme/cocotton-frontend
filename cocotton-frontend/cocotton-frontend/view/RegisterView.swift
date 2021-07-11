//
//  RegisterView.swift
//  cocotton-frontend
//
//  Created by Developer on 11/07/2021.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var username = ""
    @State private var password = ""
    
    
    
    
    @State private var emptyMandatoryFields = false
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 15) {
                
                Spacer()
                
                Text("Register page")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                Spacer()
                HStack {
                    Image(systemName: "person.fill").foregroundColor(.black)
                    TextField("Username", text: $username)
                    Text("*").foregroundColor(.red)
                }
                .padding(.all, 10)
                .background(Color.white.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                
                HStack {
                    Image(systemName: "lock.fill").foregroundColor(.black)
                    SecureField("Password", text: $password)
                    Text("*").foregroundColor(.red)
                }
                .padding(.all, 10)
                .background(Color.white.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                
                HStack {
                    Text("*").foregroundColor(.red)
                    Text(": Mandatory fields.")
                }
                .padding(.all, 8)
                .font(.system(size: 15))
                .background(Color.white.opacity(0.8))
                .cornerRadius(8)
                .padding(.trailing, 220)
                
                NavigationLink(
                    destination: MainView(),
                    label: {
    //                    Button(action: {tryLogin()}, label: {
                            Text("Register")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: Font.Weight.medium))
                                .padding()
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(8)
    //                    })
    //                    .alert(isPresented: $emptyMandatoryFields) {
    //                        Alert(
    //                            title: Text("Empty mandatory fields"),
    //                            message: Text("Mandatory fields must be filled.")
    //                        )
    //                    }
                })
                
                Spacer()
            }
            .background(
                Image("register_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 2)
            ).edgesIgnoringSafeArea(.all)
            
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

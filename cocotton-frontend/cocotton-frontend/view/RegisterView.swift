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
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var birthDate = Date()
    
    @State private var emptyMandatoryFields = false
    @State private var isGoodForLoad = false
    @State private var isWrongCredentials = false
    
    private let authController: AuthController = AuthController()
    
    var body: some View {
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
                Group {
                    HStack {
                        Image(systemName: "person.2.fill").foregroundColor(.black)
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
                        Image(systemName: "envelope.fill").foregroundColor(.black)
                        TextField("Email adress", text: $email)
                        Text("*").foregroundColor(.red)
                    }
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    
                    HStack {
                        Image(systemName: "person.circle.fill").foregroundColor(.black)
                        TextField("First name", text: $firstName)
                        Text("*").foregroundColor(.red)
                    }
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    
                    HStack {
                        Image(systemName: "person.circle.fill").foregroundColor(.black)
                        TextField("Last name", text: $lastName)
                        Text("*").foregroundColor(.red)
                    }
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    
                    HStack {
                        Image(systemName: "calendar.badge.exclamationmark").foregroundColor(.black)
                        DatePicker("Birth date", selection: $birthDate, displayedComponents: .date)
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
                }
                
                Spacer()
                                
                NavigationLink(
                    destination: LoadingView(textAction: "Registering").onAppear {
                        LoadingView(textAction: "Registering").tryRegister(registerCredential: RegisterCredential(username: self.username, password: self.password, email: self.email, firstName: self.firstName, lastName: self.lastName, birthDate: self.birthDate))
                    }, isActive: $isGoodForLoad,
                    label: {
                })
                Button(action: {viewBehavior()}, label: {
                    Text("Register")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: Font.Weight.medium))
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(8)
                })
                
                Spacer()
                
                
            }
            .alert(isPresented: $isWrongCredentials, content: {
                Alert(
                    title: Text("Wrong credentials"),
                    message: Text("Your credentials are wrong. Try creating an account !")
                )
            })
            .alert(isPresented: $emptyMandatoryFields) {
                Alert(
                    title: Text("Empty mandatory fields"),
                    message: Text("Mandatory fields must be filled.")
                )
            }
            .background(
                Image("register_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 2)
            ).edgesIgnoringSafeArea(.all)
    }
    
    func viewBehavior() {
        print("viewBehave")
        if username != "" && password != "" && firstName != "" && lastName != "" && email != "" {
            isGoodForLoad = true
            print("isGoodForLoad = " + isGoodForLoad.description)
        } else {
            emptyMandatoryFields = true
            print("emptyMandatoryFields = " + emptyMandatoryFields.description)
        }
    }
    
    func displayWrongCredentials() {
        isWrongCredentials = true
        print("isWrongCredentials = " + isWrongCredentials.description)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}


struct RegisterCredential: Codable {
    
    let username: String
    let password: String
    let email: String
    let firstName: String
    let lastName: String
    let birthDate: Date
    
    init(username: String, password: String, email: String, firstName: String, lastName: String, birthDate: Date) {
        self.username = username
        self.password = password
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
}

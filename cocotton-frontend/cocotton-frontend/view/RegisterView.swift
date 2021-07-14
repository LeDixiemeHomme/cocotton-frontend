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
    
    @State private var displayAlert = false
    @State private var alert: Alert = Alert(title: Text("Empty alert"))
    
    @State private var emptyMandatoryFields = false
    @State private var isGoodForLoad = false
    @State private var isWrongCredentials = false
    
    private let authController: AuthController = AuthController()
    
    var body: some View {
        Group { //group 1
            VStack(spacing: 15) { //VStack 1
                Spacer()
                Text("Register page")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                Spacer()
                Group { //group 2
                    HStack {
                        Image(systemName: "person.2.fill").foregroundColor(.black)
                        TextField("Username", text: $username)
                            .autocapitalization(.none)
                        Text("*").foregroundColor(.red)
                    }
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    
                    HStack {
                        Image(systemName: "lock.fill").foregroundColor(.black)
                        SecureField("Password", text: $password)
                            .autocapitalization(.none)
                        Text("*").foregroundColor(.red)
                    }
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    
                    HStack {
                        Image(systemName: "envelope.fill").foregroundColor(.black)
                        TextField("Email adress", text: $email)
                            .autocapitalization(.none)
                        Text("*").foregroundColor(.red)
                    }
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    
                    HStack {
                        Image(systemName: "person.circle.fill").foregroundColor(.black)
                        TextField("First name", text: $firstName)
                            .autocapitalization(.none)
                        Text("*").foregroundColor(.red)
                    }
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    
                    HStack {
                        Image(systemName: "person.circle.fill").foregroundColor(.black)
                        TextField("Last name", text: $lastName)
                            .autocapitalization(.none)
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
                } //end groupe 2
                                
                NavigationLink(
                    destination: LoadingView(textAction: "Registering", registerCredential: RegisterCredential(username: self.username, password: self.password, email: self.email, firstName: self.firstName, lastName: self.lastName, birthDate: self.birthDate)), isActive: $isGoodForLoad,
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
                
            }//end VStack 1
            .background(
                Image("login_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 2)
            ).edgesIgnoringSafeArea(.all)
        }//end group 1
        .alert(isPresented: $displayAlert, content: {
            self.alert
        })
    }
    
    func viewBehavior() {
        if username != "" && password != "" && firstName != "" && lastName != "" && email != "" {
            isGoodForLoad = true
        } else {
            alert =  Alert(
                    title: Text("Empty mandatory fields"),
                    message: Text("Mandatory fields must be filled.")
                )
            displayAlert = true
        }
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

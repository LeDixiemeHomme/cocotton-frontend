//
//  RegisterView.swift
//  cocotton-frontend
//
//  Created by Developer on 11/07/2021.
//

import SwiftUI
import SwiftKeychainWrapper

struct RegisterView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var birthDate = Date()
    
    @State private var isLoading = false
    @State public var isCredentialsCorrect = false
    
    @State private var displayAlert = false
    @State private var alert: Alert = Alert(title: Text("Empty alert"))
    private let backGround: String = "login_background"
    
    private let authController: AuthController = AuthController()
    private let profileController: ProfileController = ProfileController()
    
    var body: some View {
        VStack(spacing: 15){ //VStack 1
            if isLoading { //if 1
                LoadingView(textAction: "Registering", backGround: self.backGround)
            } // end of 1
            else { // else 1
                
                Spacer()
                
                Text("Register page")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                
                Spacer()
                
                Group { //group 1
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
                } //end group 1
                
                Button(action: {viewBehavior()}, label: {
                    Text("Register")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: Font.Weight.medium))
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(8)
                })
                
                Spacer()
                
            } // end else 1
            
            NavigationLink(
                destination: InitialTabView(tabSelection: 3),
                isActive: $isCredentialsCorrect,
                label: {})
            
        }//end VStack 1
        .background(
            Image(self.backGround)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 2)
        ).edgesIgnoringSafeArea(.all)
        .alert(isPresented: $displayAlert, content: {
            self.alert
        }).onAppear(perform: {
            print("disappear RegisterView")
        }).onDisappear(perform: {
            print("disappear RegisterView")
        })
    }
    
    func viewBehavior() {
        if username != "" && password != "" && firstName != "" && lastName != "" && email != "" {
            tryRegister(registerCredential: RegisterCredential(username: self.username, password: self.password, email: self.email, firstName: self.firstName, lastName: self.lastName, birthDate: self.birthDate))
        } else {
            alert =  Alert(
                    title: Text("Empty mandatory fields"),
                    message: Text("Mandatory fields must be filled.")
                )
            displayAlert = true
        }
    }
    
    func tryRegister(registerCredential: RegisterCredential) -> Void {
        isLoading = true
        
        let dateFormatter = DateFormatter()
        let profile: Profile = Profile(lastName: registerCredential.lastName, firstName: registerCredential.firstName, email: registerCredential.email, username: registerCredential.username, password: registerCredential.password, birthDate: dateFormatter.string(from: registerCredential.birthDate))
        
        if let unwrappedProfileId: String = authController.register(profile: profile) {
            
            KeychainWrapper.standard[.profileId] = unwrappedProfileId
            KeychainWrapper.standard[.lastName] = profile.lastName
            KeychainWrapper.standard[.firstName] = profile.firstName
            KeychainWrapper.standard[.email] = profile.email
            KeychainWrapper.standard[.username] = profile.username
            KeychainWrapper.standard[.birthDate] = profile.birthDate
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                isLoading = false
                isCredentialsCorrect = true
            }
            return
        } else {
            
            print("ici set le faux token ")
            KeychainWrapper.standard[.tokenSession] = "fake-token"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                isLoading = false
                isCredentialsCorrect = true
            }
            return
                
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                isLoading = false
//                alert = Alert(
//                    title: Text("Wrong credentials"),
//                    message: Text("Your credentials are wrong. Try to create an account !")
//                )
//                displayAlert = true
//                return
//            }
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

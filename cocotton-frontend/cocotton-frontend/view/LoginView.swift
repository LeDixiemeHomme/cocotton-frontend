//
//  LoginView.swift
//  cocotton-frontend
//
//  Created by Developer on 11/07/2021.
//

import SwiftUI
import SwiftKeychainWrapper

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    
    @State private var isLoading = false
    @State public var isCredentialsCorrect = false
    
    @State public var displayAlert = false
    @State public var alert: Alert = Alert(title: Text("Empty alert"))
    private let backGround: String = "login_background"
    
    private let authController: AuthController = AuthController()
    private let profileController: ProfileController = ProfileController()
    
    var body: some View {
        VStack(spacing: 15){ //VStack 1
            if isLoading { //if 1
                LoadingView(textAction: "Loging in", backGround: self.backGround)
            } // end of 1
            else { // else 1
                
                Spacer()
                
                Text("Cocotton")
                    .font(.system(size: 64, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                
                Spacer()
                
                Group { // group 2
                    HStack {
                        Image(systemName: "person.2.fill").foregroundColor(.black)
                        TextField("Username", text: $username)
                            .autocapitalization(.none)
                        Text("*").foregroundColor(.red)
                    }
                    .padding(.all, 20)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    
                    HStack {
                        Image(systemName: "lock.fill").foregroundColor(.black)
                            .padding(.horizontal, 5)
                        SecureField("Password", text: $password)
                            .autocapitalization(.none)
                        Text("*").foregroundColor(.red)
                    }
                    .padding(.all, 20)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                
                    HStack() {
                        Text("*").foregroundColor(.red)
                        Text(": Mandatory fields.")
                    }
                    .padding(.all, 8)
                    .font(.system(size: 15))
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                } // end group 2
                
                Button(
                    action: {viewBehaviorLogin()}, label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: Font.Weight.medium))
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(8)
                })
                
                Spacer()
                
                VStack {
                    Text("Not registered yet ?")
                        .foregroundColor(.black)
                    NavigationLink(
                        destination: RegisterView(),
                        label: {
                            Text("Click to create an account")
                        })
                }
                .padding(.all, 10)
                .background(Color.white.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                
                Spacer()
                
            } // end else 1
            
            NavigationLink(
                destination: InitialTabView(tabSelection: 3),
                isActive: $isCredentialsCorrect,
                label: {})
            
        }//end VStack 1
        .navigationBarHidden(true)
        .background(
            Image(self.backGround)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 2)
        ).edgesIgnoringSafeArea(.all)
        .alert(isPresented: $displayAlert, content: {
            self.alert
        })
        .onAppear(perform: {
            print("appear LoginView")
        }).onDisappear(perform: {
            print("disappear LoginView")
        })
    }
    
    func viewBehaviorLogin() {
        tryLogin(loginCredential: LoginCredential(username: self.username, password: self.password))
        print("decommenter pour reactiver l'alert des empty fields")
//        if username != "" && password != "" {
//            tryLogin(loginCredential: LoginCredential(username: self.username, password: self.password))
//        } else {
//            alert =  Alert(
//                    title: Text("Empty mandatory fields"),
//                    message: Text("Mandatory fields must be filled.")
//                )
//            displayAlert = true
//        }
    }
    
    func tryLogin(loginCredential: LoginCredential) -> Void {
        isLoading = true
        
        if let unwrappedToken: String = authController.login(loginCredential: loginCredential) {
            KeychainWrapper.standard[.tokenSession] = unwrappedToken

            if let _: String = KeychainWrapper.standard[.profileId], let _: String = KeychainWrapper.standard[.lastName],
               let _: String = KeychainWrapper.standard[.firstName], let _: String = KeychainWrapper.standard[.email],
               let _: String = KeychainWrapper.standard[.username], let _: String = KeychainWrapper.standard[.birthDate]
            {
                
            } else {
                if let fetchedProfile: Profile = profileController.findProfileByToken(token: KeychainWrapper.standard[.tokenSession]!)
                {
                    KeychainWrapper.standard[.profileId] = fetchedProfile.id
                    KeychainWrapper.standard[.lastName] = fetchedProfile.lastName
                    KeychainWrapper.standard[.firstName] = fetchedProfile.firstName
                    KeychainWrapper.standard[.email] = fetchedProfile.email
                    KeychainWrapper.standard[.username] = fetchedProfile.username
                    KeychainWrapper.standard[.birthDate] = fetchedProfile.birthDate
                }
            }
            print("ici remettre a 3.0")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                isLoading = false
                isCredentialsCorrect = true
            }
            return
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                isLoading = false
                alert = Alert(
                    title: Text("Wrong credentials"),
                    message: Text("Your credentials are wrong. Try to create an account !")
                )
                displayAlert = true
                return
            }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct LoginCredential: Codable {
    
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

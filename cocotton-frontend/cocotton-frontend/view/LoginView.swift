//
//  LoginView.swift
//  cocotton-frontend
//
//  Created by Developer on 11/07/2021.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    
    @State private var isGoodForLoad = false
    
    @State public var displayAlert = false
    @State public var alert: Alert = Alert(title: Text("Empty alert"))
    
    private let authController: AuthController = AuthController()

    var body: some View {
        Group { //group 1
            VStack(spacing: 15) { //VStack 1
                Spacer()
                Text("Cocotton")
                    .font(.system(size: 64, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                Spacer()
                Group {
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
                }
                
                NavigationLink(
                    destination: LoadingView(textAction: "Loging in", loginCredential: LoginCredential(username: self.username, password: self.password)), isActive: $isGoodForLoad,
                    label: {
                })
                
                Button(
                    action: {viewBehavior()}, label: {
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
        
        //a delete debut
            isGoodForLoad = true
        //a delete fin
        
        print("decommenter pour que ça remarche")
//        if username != "" && password != "" {
//            isGoodForLoad = true
//        } else {
//            alert =  Alert(
//                    title: Text("Empty mandatory fields"),
//                    message: Text("Mandatory fields must be filled.")
//                )
//            displayAlert = true
//        }
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

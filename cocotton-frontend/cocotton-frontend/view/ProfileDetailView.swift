//
//  ProfileDetailView.swift
//  cocotton-frontend
//
//  Created by Developer on 19/07/2021.
//

import SwiftUI
import SwiftKeychainWrapper

struct ProfileDetailView: View {
    
    @State private var username = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var birthDate = ""
    @State private var profileId = ""
    
    @State private var isDeconnected = false
    @State private var isLoading = false
    private let backGround: String = "loading_background"
    
    var body: some View {
        VStack(spacing: 15){ //VStack 1
            if isLoading { //if 1
                LoadingView(textAction: "Loging out", backGround: self.backGround)
            } // end if 1
            else {
                Spacer()
                    
                Text("User info")
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                
                    VStack { //VStack 2
                        List {
                            HStack {
                                Image(systemName: "person.circle.fill").foregroundColor(.black)
                                Text("Last name : \(self.lastName)")
                            }
                            .padding(.all, 10)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                            .padding(.horizontal, 10)
                            HStack {
                                Image(systemName: "person.circle.fill").foregroundColor(.black)
                                Text("First name : \(self.firstName)")
                            }
                            .padding(.all, 10)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                            .padding(.horizontal, 10)
                            HStack {
                                Image(systemName: "person.2.fill").foregroundColor(.black)
                                Text("Username : \(self.username)")
                            }
                            .padding(.all, 10)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                            .padding(.horizontal, 10)
                            HStack {
                                Image(systemName: "envelope.fill").foregroundColor(.black)
                                Text("Email : \(self.email)")
                            }
                            .padding(.all, 10)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                            .padding(.horizontal, 10)
                            HStack {
                                Image(systemName: "calendar.badge.exclamationmark").foregroundColor(.black)
                                Text("Birth date : \(self.birthDate)")
                            }
                            .padding(.all, 10)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                            .padding(.horizontal, 10)
                        }
                        .frame(height: 260)
                        
                    }// end VStack 2
                    .padding(.vertical)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .onAppear{
                        if let username: String = KeychainWrapper.standard[.username] {
                            self.username = username
                        }
                        if let lastName: String = KeychainWrapper.standard[.lastName] {
                            self.lastName = lastName
                        }
                        if let firstName: String = KeychainWrapper.standard[.firstName] {
                            self.firstName = firstName
                        }
                        if let email: String = KeychainWrapper.standard[.email] {
                            self.email = email
                        }
                        if let birthDate: String = KeychainWrapper.standard[.birthDate] {
                            self.birthDate = birthDate
                        }
                        if let profileId: String = KeychainWrapper.standard[.profileId] {
                            self.profileId = profileId
                        }
                    }
                Button(
                    action: {clearToken()}, label: {
                    Text("Logout")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: Font.Weight.medium))
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(8)
                })
                Spacer()
            }
            
            NavigationLink(
                destination: LoginView().navigationBarBackButtonHidden(true),
                isActive: $isDeconnected,
                label: {})
        }//end VStack 1
        .background(
            Image(self.backGround)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 2)
        ).edgesIgnoringSafeArea(.all)
    }
    
    func clearToken() -> Void {
        isLoading = true
        KeychainWrapper.standard.remove(forKey: .tokenSession)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isLoading = false
            isDeconnected = true
        }
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView()
    }
}

//NavigationLink(
//    destination: InitialTabView(tabSelection: 2),
//    isActive: $isCredentialsCorrect,
//    label: {})

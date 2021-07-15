//
//  LoadingView.swift
//  cocotton-frontend
//
//  Created by Developer on 11/07/2021.
//

import SwiftUI
import SwiftKeychainWrapper

struct LoadingView: View {
    
    let timer = Timer.publish(every: 1.6, on: .main, in: .common).autoconnect()
    @State var leftOffset: CGFloat = -100
    @State var rightOffset: CGFloat = 100
    
    @State var timeToWait: Int?
    @State var textAction: String
    @State var registerCredential: RegisterCredential?
    @State var loginCredential: LoginCredential?
    
    @State public var isCredentialsWrong = false
    @State public var isCredentialsCorrect = false
    
    private let authController: AuthController = AuthController()
    private let profileController: ProfileController = ProfileController()
    
    var body: some View {
        Group {// group 1
            VStack{ //VStack 1
                Spacer()
                
                TextField("Loading action", text: $textAction)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                    .padding(20)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 20, height: 20)
                        .offset(x: leftOffset)
                        .animation(Animation.easeInOut(duration: 1))
                    Circle()
                        .fill(Color.white)
                        .frame(width: 20, height: 20)
                        .offset(x: leftOffset)
                        .animation(Animation.easeInOut(duration: 1).delay(0.2))
                    Circle()
                        .fill(Color.red)
                        .frame(width: 20, height: 20)
                        .offset(x: leftOffset)
                        .animation(Animation.easeInOut(duration: 1).delay(0.4))
                }
                .onReceive(timer) { (_) in
                    swap(&self.leftOffset, &self.rightOffset)
                }
                
                Spacer()
                
                if isCredentialsCorrect {
                    InitialTabView()
                } else if isCredentialsWrong {
                    LoginView(displayAlert: true, alert: Alert(
                        title: Text("Wrong credentials"),
                        message: Text("Your credentials are wrong. Try to create an account !")
                    )).navigationBarBackButtonHidden(true)
                }
                
            }// end VStack 1
            .background(
                Image("register_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 5)
            ).edgesIgnoringSafeArea(.all)
        }// end group 1
        .onAppear {
            if let loginCredential: LoginCredential = self.loginCredential {
                tryLogin(loginCredential: loginCredential)
            } else if let registerCredential: RegisterCredential = self.registerCredential {
                tryRegister(registerCredential: registerCredential)
            } else if let timeToWait: Int = self.timeToWait {
                tryWaitForPresentation(time: timeToWait)
            }
        }
    }
    
    func tryLogin(loginCredential: LoginCredential) -> Void {
        print("///////////////////passe dans le tryLogin")
        if let unwrappedToken: String = authController.login(loginCredential: loginCredential) {
            print("///////////////////passe dans le tryLogin if")
            print("unwrappedToken")
            print(unwrappedToken)
            KeychainWrapper.standard[.tokenSession] = unwrappedToken

            if let _: String = KeychainWrapper.standard[.profileId], let _: String = KeychainWrapper.standard[.lastName],
               let _: String = KeychainWrapper.standard[.firstName], let _: String = KeychainWrapper.standard[.email],
               let _: String = KeychainWrapper.standard[.username], let _: String = KeychainWrapper.standard[.birthDate]
            {
                print("///////////////////passe dans le test du key wrapper if")
                isCredentialsCorrect = true
            } else {
                print("///////////////////passe dans le test du key wrapper else")
                self.textAction = "Updating local data"
                if let fetchedProfile: Profile = profileController.findProfileByToken(token: KeychainWrapper.standard[.tokenSession]!)
                {
                    KeychainWrapper.standard[.profileId] = fetchedProfile.id
                    KeychainWrapper.standard[.lastName] = fetchedProfile.lastName
                    KeychainWrapper.standard[.firstName] = fetchedProfile.firstName
                    KeychainWrapper.standard[.email] = fetchedProfile.email
                    KeychainWrapper.standard[.username] = fetchedProfile.username
                    KeychainWrapper.standard[.birthDate] = fetchedProfile.birthDate
                }
                isCredentialsCorrect = true
            }
        } else {
            print("///////////////////passe dans le tryLogin else")
            isCredentialsWrong = true
        }
    }
    
    func tryRegister(registerCredential: RegisterCredential) -> Void {
        print("///////////////////passe dans le tryRegister")
        let dateFormatter = DateFormatter()
        let profile: Profile = Profile(lastName: registerCredential.lastName, firstName: registerCredential.firstName, email: registerCredential.email, username: registerCredential.username, password: registerCredential.password, birthDate: dateFormatter.string(from: registerCredential.birthDate))
        
        if let unwrappedProfileId: String = authController.register(profile: profile) {
            
            KeychainWrapper.standard[.profileId] = unwrappedProfileId
            KeychainWrapper.standard[.lastName] = profile.lastName
            KeychainWrapper.standard[.firstName] = profile.firstName
            KeychainWrapper.standard[.email] = profile.email
            KeychainWrapper.standard[.username] = profile.username
            KeychainWrapper.standard[.birthDate] = profile.birthDate
            
            isCredentialsCorrect = true
            
        } else {
            isCredentialsWrong = true
        }
    }
    
    func tryWaitForPresentation(time: Int) -> Void {
        sleep(UInt32(time))
        LoginView(displayAlert: true, alert: Alert(
            title: Text("End of the waiting.")
        ))
    }
    
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(textAction: "Loading preview")
    }
}

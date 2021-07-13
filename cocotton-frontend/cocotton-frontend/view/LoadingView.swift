//
//  LoadingView.swift
//  cocotton-frontend
//
//  Created by Developer on 11/07/2021.
//

import SwiftUI

struct LoadingView: View {
    
    let timer = Timer.publish(every: 1.6, on: .main, in: .common).autoconnect()
    @State var leftOffset: CGFloat = -100
    @State var rightOffset: CGFloat = 100
    
    @State var textAction: String
    
    @State public var isCredentialsWrong = false
    @State public var isCredentialsCorrect = false
    
    private let authController: AuthController = AuthController()
    
    var body: some View {
        
        NavigationView {
            VStack{
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
                
                NavigationLink(
                    destination: LoginView().onAppear(perform: {
                        LoginView().displayWrongCredentials()
                    }), isActive: $isCredentialsWrong,
                    label: {
                })
                
                NavigationLink(
                    destination: MainView(), isActive: $isCredentialsCorrect,
                    label: {
                })
                
            }
            .background(
                Image("loading_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 5)
            ).edgesIgnoringSafeArea(.all)
        }
    }
    
    func tryLogin(loginCredential: LoginCredential) {
        if let _unwrapped: String = authController.login(loginCredential: loginCredential) {
            // placer le token dans le userdata ?? ou ailleurs
            isCredentialsCorrect = true
        } else {
            isCredentialsWrong = true
        }
    }
    
    func tryRegister(registerCredential: RegisterCredential) {
        let dateFormatter = DateFormatter()
        let profile: Profile = Profile(lastName: registerCredential.lastName, firstName: registerCredential.firstName, email: registerCredential.email, username: registerCredential.username, password: registerCredential.password, birthDate: dateFormatter.string(from: registerCredential.birthDate))
        if let _unwrapped: String = authController.register(profile: profile) {
            print(_unwrapped)
        } else {
            isCredentialsWrong = true
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(textAction: "Loading preview")
    }
}

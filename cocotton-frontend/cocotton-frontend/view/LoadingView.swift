//
//  LoadingView.swift
//  cocotton-frontend
//
//  Created by Developer on 11/07/2021.
//

import SwiftUI
import SwiftKeychainWrapper

struct LoadingView: View {
    
    let timer = Timer.publish(every: 0.7, on: .main, in: .common).autoconnect()
    @State private var leftOffset: CGFloat = -50
    @State private var rightOffset: CGFloat = 50
    
    @State public var textAction: String
    @State public var backGround: String
    
    var body: some View {
        VStack { //VStack 1
            Spacer()
            
            Text(self.textAction)
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
                    .animation(Animation.easeInOut(duration: 0.5))
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                    .offset(x: leftOffset)
                    .animation(Animation.easeInOut(duration: 0.5).delay(0.2))
                Circle()
                    .fill(Color.red)
                    .frame(width: 20, height: 20)
                    .offset(x: leftOffset)
                    .animation(Animation.easeInOut(duration: 0.5).delay(0.4))
            }
            .onReceive(timer) { (_) in
                swap(&self.leftOffset, &self.rightOffset)
            }
            
            Spacer()
        } // end VStack 1
        .background(
            Image(self.backGround)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 2)
        ).edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            print("appear LoadingView")
        })
        .onDisappear(perform: {
            print("disappear LoadingView")
        })
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(textAction: "Preview LoadingView", backGround: "login_background")
    }
}

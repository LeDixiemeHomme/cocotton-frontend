//
//  ContentView.swift
//  cocotton-frontend
//
//  Created by Developer on 27/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    var fileTempController : FileTempController = FileTempController()
    
    func displayData(){
        let fetchedFile: FileTemp = fileTempController.getFileById(id: "60e8417e9362d07a5b27a4c1")
        print("fetchedFile")
        print(fetchedFile)
        print("fetchedFile")
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {displayData()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

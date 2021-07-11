//
//  ContentView.swift
//  cocotton-frontend
//
//  Created by Developer on 27/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var results = [Ingredient]()
  
    var body: some View {
        List(results, id: \.id) { item in
            VStack(alignment: .leading) {
                Text(item.fileName)
            }
        }.onAppear(perform: loadData)
    }
    
    
    func displayValue() {
        let token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ2YWxsZWIyQGdtYWlsLmNvbSIsInJvbGVzIjpbeyJpZCI6IjYwOTgwMTA0NDRlYjY4MWU4MDQxODE5MiIsInJvbGUiOiJVU0VSIn1dLCJpYXQiOjE2MjQ4ODM2NjAsImV4cCI6MTYyNDg4NzI2MH0.tGc-9Ahb3AEVghkVXZB9ikjEVmr4dGObSrkicjIILTxRwYcyAy7pVm_5fxDaD5EjYmvxYwvPIJZ-3Kpz-vGM3Q"
        let url = URL(string: "http://localhost:3010/api/v1/file")!

        // prepare json data
        let json: [String: Any] = ["State": 1]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()
        
    }
    
  
    func loadData() {
        print("func loadData()")
        guard let url = URL(string: "http://localhost:3010/api/v1/file") else {
            print("Your API end point is Invalid")
            return
        }
        
        let token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ2YWxsZWIyQGdtYWlsLmNvbSIsInJvbGVzIjpbeyJpZCI6IjYwOTgwMTA0NDRlYjY4MWU4MDQxODE5MiIsInJvbGUiOiJVU0VSIn1dLCJpYXQiOjE2MjQ5OTk1NDQsImV4cCI6MTYyNTAwMzE0NH0.KCGpGCRf6xlUoQhrZTLJev5660jLpiFE-YmZK_c1y82PZrgyR3cFFTLF0ZNQcWg_r0V245u_XftaYMQHT3_Qkg"

        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Ingredient].self, from: data) {
                    DispatchQueue.main.async {
                        self.results = response
                    }
                    return
                }
            }
        }.resume()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

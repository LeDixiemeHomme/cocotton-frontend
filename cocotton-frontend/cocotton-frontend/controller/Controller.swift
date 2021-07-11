//
//  Controller.swift
//  cocotton-frontend
//
//  Created by Developer on 29/06/2021.
//

import Foundation

struct Controller {
    
    func requestCreatorWithToken(httpMethod: String, target: String, token: String) -> URLRequest? {
        let uri: String = BASE_URL + target
        
        guard let url: URL = URL(string: uri) else {
            print("Your API end point is Invalid")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func test (obj: Any) {
        type(of: obj).self
    }
    
    func executeRequest(urlRequest: URLRequest) -> 	Result {
        var result: Result = Result()
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else { return }
            print("data")
            print(String(bytes: data, encoding: .utf8))
            guard let response = response else { return }
            print("response")
            print(response)
            if let decodedResponse: Result = try? JSONDecoder().decode(Result.self, from: data) {
                print("decodedResponse")
                print(decodedResponse)
                result = decodedResponse
            }
        }.resume()
        return result
    }
    
    func getFileById(id: String, token: String) -> FileTemp?{
        let urlRequest: URLRequest = requestCreatorWithToken(httpMethod: "GET", target: FILE_TARGET + id, token: TOKEN)!
        let result: Result = executeRequest(urlRequest: urlRequest)
        return result.fileTemp
    }
}

struct Result: Codable {
    var fileTemps: [FileTemp]?
    var fileTemp: FileTemp?
    init(){
        
    }
}


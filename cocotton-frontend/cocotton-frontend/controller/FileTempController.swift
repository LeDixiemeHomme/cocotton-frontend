//
//  FileTempController.swift
//  cocotton-frontend
//
//  Created by Developer on 10/07/2021.
//

import Foundation

let FILE_TARGET: String = "file/"

class FileTempController {
    
    let rest = RestManager()
    let fileTarget = FILE_TARGET
    
    func getFileById(id: String) -> FileTemp {
        var fileTemp: FileTemp = FileTemp()
        guard let url = URL(string: API_BASE_URL + FILE_TARGET + id) else { return fileTemp }
        rest.makeRequest(toURL: url, withHttpMethod: .get, token: TOKEN) { (results) in
            print("results")
            print(results)
            if let data = results.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let decodedData = try? decoder.decode(FileTemp.self, from: data) else { return }
                print("decodedData")
                print(decodedData)
                print("decodedData")
                fileTemp = decodedData
            }
            
            print("\n\nResponse HTTP Headers:\n")
        }
        print("fileTemp")
        print(fileTemp)
        print("fileTemp")
        return fileTemp
    }
}

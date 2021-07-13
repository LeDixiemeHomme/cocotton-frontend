//
//  FileTemp.swift
//  cocotton-frontend
//
//  Created by Developer on 29/06/2021.
//

import Foundation

struct FileTemp: Codable {    
    var id: String?
    var fileName: String?
    var filePath: String?
    var creationDate: String?
    var runDate: String?
}


struct UPToken: Codable {
    var token: String?
}

//
//  Model.swift
//  
//
//  Created by Hannes Sverrisson on 08/12/2019.
//

import Foundation

struct API_Keys: Codable {
    var sandbox: Authorization?
    var consumer: Authorization?
}

struct Authorization: Codable {
    var secret: String?
    var key: String?
}

struct Model: Codable {
    
}

//
//  Model.swift
//  
//
//  Created by Hannes Sverrisson on 08/12/2019.
//

import Foundation
import OSLog

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

// MARK: - Data Import

func loadJSON<T: Decodable>(_ name: String) -> T? {
    try? JSONDecoder().decode(T.self, from: data(name))
}

// Read from the app bundle
func data(_ name: String) -> Data {
    guard let url = Bundle.main.url(forResource: name, withExtension: "json") else { return Data()  }
    guard let data = try? Data(contentsOf: url) else { return Data() }
    return data
}

// Read and write from the temp folder
func readTemporary(_ name: String) -> Data? {
    if let dir = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
        let fileUrl = dir.appendingPathComponent(name).appendingPathExtension("json")
        return try? Data(contentsOf: fileUrl)
    }
    assertionFailure("Temporary store data failure")
    return nil
}

func writeTemporary(_ data: Data) -> Data {
    let name = "PetrolData"
    if let dir = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
        let fileUrl = dir.appendingPathComponent(name).appendingPathExtension("json")
        let options: Data.WritingOptions = [.atomicWrite]
        do {
            try data.write(to: fileUrl, options: options)
        } catch {
            assertionFailure("Temporary store data failure")
            os_log(.error, "Temporary store data failure")
        }
    }
    return data
}

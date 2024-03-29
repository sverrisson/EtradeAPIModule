//
//  Constants.swift
//  
//
//  Created by Hannes Sverrisson on 10/12/2019.
//

import Foundation
import os.log

struct Constants {
    struct Href {
        static let sandboxHost = "https://apisb.etrade.com/"
        static let consumerHost = "https://api.etrade.com/"
        static let pathToken = "oauth/request_token"
    }
}

func OAuthTokenHeader(key: String, secret: String) -> [String: String] {
    let signature = secret
    return ["oauth_consumer_key": key,
            "oauth_timestamp" : String(Int(Date().timeIntervalSince1970)),
            "oauth_nonce": UUID().uuidString,
            "oauth_signature_method": "HMAC-SHA1",
            "oauth_signature": signature,
            "oauth_callback": "oob",
            "Authorization: OAuth realm": "",
            "oauth_version": "1.0",
            "format": "json"
    ]
}

func RequestToken(mode: APIMode, key: String, secret: String, callback: @escaping (Token?) -> Void) {
    let host = mode == .consumer ? Constants.Href.consumerHost : Constants.Href.sandboxHost
    guard let url = URL(string: host + Constants.Href.pathToken) else {
        assertionFailure("RequestToken not an url!")
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    let headers = OAuthTokenHeader(key: key, secret: secret)
    headers.forEach { (arg0) in
        let (headerField, value) = arg0
        request.setValue(value, forHTTPHeaderField: headerField)
    }
    os_log(.error, "Request sent: %{private}@", request.description)
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            assertionFailure("Error!")
            return
        }
        os_log(.error, "Server response: %{private}@", response?.description ?? "")
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 401 else {
                print("String: \(String(data: data!, encoding: .utf8))")
                assertionFailure("ServerError, headers sent: \(headers)")
                return
        }
        guard let data = data else {
            assertionFailure("DataError")
            return
        }
        let string = String(data: data, encoding: .utf8)
        return callback(string)
    }.resume()
}

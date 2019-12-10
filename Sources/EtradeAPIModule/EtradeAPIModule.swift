import Foundation
import XMLParsing

public enum APIMode {
    case sandbox
    case consumer
}

public typealias Token = String

public class EtradeAPIModule {
    public var apiKeys: API_Keys?
    public var apiToken: Token?
    var apiQueue: DispatchQueue
    var mode: APIMode
    
    public init(mode: APIMode) {
        // Import keys
        self.mode = mode
        apiQueue = DispatchQueue(label: "EtradeAPI", qos: .utility, attributes: .concurrent, autoreleaseFrequency: .inherit)
        importKeys(mode: mode)
    }
    
    public func importKeys(mode: APIMode) {
        let name = ""
        if let keys: API_Keys = loadJSON(name) {
            apiKeys = keys
        } else {
            assertionFailure("Keys not loading from bundle")
        }
    }
    
    public func requestToken(callback: @escaping (Token?) -> Void) {
        guard let key = apiKeys?.sandbox?.key,
            let secret = apiKeys?.sandbox?.secret else {
            fatalError("apiKeys not ready")
        }
        RequestToken(mode: mode, key: key, secret: secret) { (token) in
            DispatchQueue.main.async {
                self.apiToken = token
                callback(token)
            }
        }
    }
    
}

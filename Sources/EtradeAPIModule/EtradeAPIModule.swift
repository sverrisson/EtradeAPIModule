import Foundation
import XMLParsing

public enum APIMode {
    case sandbox
    case consumer
}

public class EtradeAPIModule {
    public var apiKeys: API_Keys!
    
    public init(mode: APIMode) {
        // Import keys
    }
    
    public func importKeys(mode: APIMode) {
        let name = ""
        if let keys: API_Keys = loadJSON(name) {
            apiKeys = keys
        } else {
            assertionFailure("Keys not loading from bundle")
        }
    }
    
    
}

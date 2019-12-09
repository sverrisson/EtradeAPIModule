import Foundation
import XMLParsing

enum APIMode {
    case sandbox
    case consumer
}

class EtradeAPIModule {
    var apiKeys: API_Keys!
    
    init(mode: APIMode) {
        // Import keys
    }
    
    func importKeys(mode: APIMode) {
        let name = ""
        if let keys: API_Keys = loadJSON(name) {
            apiKeys = keys
        } else {
            assertionFailure("Keys not loading from bundle")
        }
    }
    
    
}

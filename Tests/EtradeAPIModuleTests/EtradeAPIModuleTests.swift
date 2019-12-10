import XCTest
import EtradeAPIModule
@testable import EtradeAPIModule

final class EtradeAPIModuleTests: XCTestCase {

    func testKeysLoading() {
        let name = "api_keys_sample"
        let keys: API_Keys = loadJSON(name)!
        XCTAssertNotNil(keys, "Keys nil")
        XCTAssertNotNil(keys.sandbox, "Keys nil")
        XCTAssertNotNil(keys.sandbox?.key, "Keys nil")
        XCTAssertNotNil(keys.sandbox?.secret, "Keys nil")
    }
    
    func testKeyImport() {
        let mode: APIMode = .sandbox
        let etrade = EtradeAPIModule(mode: mode)
        XCTAssertNotNil(etrade.apiKeys.sandbox, "Sandbox keys not loading")
    }

    static var allTests = [
        ("testKeyImport", testKeyImport),
    ]
}

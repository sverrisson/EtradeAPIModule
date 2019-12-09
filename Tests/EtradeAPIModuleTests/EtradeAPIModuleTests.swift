import XCTest
import EtradeAPIModule
@testable import EtradeAPIModule

final class EtradeAPIModuleTests: XCTestCase {
    func testKeyImport() {
        let mode: APIMode = .sandbox
        let etrade = EtradeAPIModule(mode: mode)
        XCTAssertNotNil(etrade.apiKeys.sandbox, "Sandbox keys not loading")
    }

    static var allTests = [
        ("testKeyImport", testKeyImport),
    ]
}

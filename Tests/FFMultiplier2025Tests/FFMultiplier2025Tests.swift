import XCTest
import OSLog
import Foundation
@testable import FFMultiplier2025

let logger: Logger = Logger(subsystem: "FFMultiplier2025", category: "Tests")

@available(macOS 13, *)
final class FFMultiplier2025Tests: XCTestCase {

    func testFFMultiplier2025() throws {
        logger.log("running testFFMultiplier2025")
        XCTAssertEqual(1 + 2, 3, "basic test")
    }

    func testDecodeType() throws {
        // load the TestData.json file from the Resources folder and decode it into a struct
        let resourceURL: URL = try XCTUnwrap(Bundle.module.url(forResource: "TestData", withExtension: "json"))
        let testData = try JSONDecoder().decode(TestData.self, from: Data(contentsOf: resourceURL))
        XCTAssertEqual("FFMultiplier2025", testData.testModuleName)
    }

}

struct TestData : Codable, Hashable {
    var testModuleName: String
}

import XCTest
import OSLog
import Foundation
@testable import FFMultiplierModel

let logger: Logger = Logger(subsystem: "FFMultiplierModel", category: "Tests")

@available(macOS 13, *)
final class FFMultiplierModelTests: XCTestCase {

    func testFFMultiplierModel() throws {
        logger.log("running testFFMultiplierModel")
        XCTAssertEqual(1 + 2, 3, "basic test")
    }

    func testDecodeType() throws {
        // load the TestData.json file from the Resources folder and decode it into a struct
        let resourceURL: URL = try XCTUnwrap(Bundle.module.url(forResource: "TestData", withExtension: "json"))
        let testData = try JSONDecoder().decode(TestData.self, from: Data(contentsOf: resourceURL))
        XCTAssertEqual("FFMultiplierModel", testData.testModuleName)
    }

}

struct TestData : Codable, Hashable {
    var testModuleName: String
}

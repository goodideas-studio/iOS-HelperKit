import XCTest
@testable import GISHelperKit

final class GISHelperKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GISHelperKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

import XCTest
import GISHelperKit

final class GISHelperKitTests: XCTestCase {
	func testArraySum() {
		let list = (1...5).map{$0}
		let expect = list
			.reduce(0, +)
		let result = list.sum(by: \.self)
		XCTAssertEqual(expect, result)
	}
	
	static var allTests = [
		("testArraySum", testArraySum),
	]
}

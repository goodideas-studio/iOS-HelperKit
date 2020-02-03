//
//  PhantomTests.swift
//  GISHelperKitTests
//
//  Created by 游宗諭 on 2019/12/11.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import XCTest
import GISHelperKit

class PhantomTests: XCTestCase {

	enum MyDateString {}
	typealias DateStr  = PhantomType<MyDateString, String>
	@Phantom<MyDateString, String> var dateStr = "test"
	func testPhantom() {
		let dateStr: DateStr = DateStr("test")
		XCTAssertEqual(dateStr, $dateStr)
		XCTAssertEqual(dateStr.value, self.dateStr)
	}
}

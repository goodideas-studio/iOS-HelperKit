//
//  NumericTests.swift
//  GISHelperKitTests
//
//  Created by 游宗諭 on 2019/12/5.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import XCTest
import GISHelperKit
class NumericTests: XCTestCase {
	func testCommaString() {
		let int1: Int = 1_000
		let expect1 = int1.commaString()
		XCTAssertEqual("1,000", expect1)

		let int2: Double = 1_000.1234
		let expect2 = int2.commaString(floatPointPosition: 2)
		XCTAssertEqual("1,000.12", expect2)
	}

	func testDoubleFloored() {
		let double = 1.1234
		let expect = 1.1
		XCTAssertEqual(expect, double.floored(toPosition: 1))
	}
}

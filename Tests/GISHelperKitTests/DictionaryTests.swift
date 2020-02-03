//
//  DictionaryTests.swift
//  GISHelperKitTests
//
//  Created by 游宗諭 on 2019/12/13.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import XCTest
import GISHelperKit
class DictionaryTests: XCTestCase {

	func testDicNiceDump() {
		let s =
			[
			"1": "1",
			"2": "2"
		]
		s.niceDump()
	}
	func testDicIfGet() {
		let dic = [1: "1"]
		XCTAssertEqual(dic[fi: 1], "1")
		XCTAssertEqual(dic[fi: 2, ifNot: "3"], "3")

		let dicSame = [1: 1]

		XCTAssertEqual(dicSame[if: 1], 1)
		XCTAssertEqual(dicSame[if: 2], 2)
	}
}

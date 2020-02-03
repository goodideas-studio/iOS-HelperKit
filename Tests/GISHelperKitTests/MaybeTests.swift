//
//  MaybeTests.swift
//  GISHelperKitTests
//
//  Created by 游宗諭 on 2019/12/10.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import XCTest
import GISHelperKit
class MaybeTests: XCTestCase {
	struct B: Codable {
		var a: Int
	}
	func testMaybeConvert() {
		let json = #"""
		[{"a":0}, 1]
		"""#.data(using: .utf8)!
		let maybe = try! JSONDecoder().decode(Maybe.self, from: json)
		let b = try! maybe.array[0].convent(to: B.self)
		dump(b)
	}
}

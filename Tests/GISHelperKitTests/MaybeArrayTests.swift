//
//  MaybeArray.swift
//  GISHelperKitTests
//
//  Created by 游宗諭 on 2020/1/3.
//  Copyright © 2020 ytyubox. All rights reserved.
//

import XCTest
import GISHelperKit

class MaybeArrayTests: XCTestCase {
	struct GroceryProduct: Codable {
		var name: String
		var points: Int
		var description: String?
	}

	func testMaybeArray() {
		let json = #"""
		[
		    {
		        "name": "Banana",
		        "points": 200,
		        "description": "A banana grown in Ecuador."
		    },
		    {
		        "name": "Orange"
		    }
		]
		"""#.data(using: .utf8)!

		let products = try! JSONDecoder()
			.decode(MaybeArray<GroceryProduct>.self, from: json)
			.elements
		XCTAssertEqual(1, products.count)
	}
	func testMaybeArrayWithEmptyArray() {
		let json = #"""
		[
		]
		"""#.data(using: .utf8)!

		let products = try! JSONDecoder()
			.decode(MaybeArray<GroceryProduct>.self, from: json)
			.elements
		XCTAssertEqual(0, products.count)
	}
	func testMaybeArrayWithAllWrong() {
		let json = #"""
			[
		    {
		        "points": 200,
		        "description": "A banana grown in Ecuador."
		    },
		    {
		        "name": "Orange"
		    }
		]
		"""#.data(using: .utf8)!
		do {
		let products = try JSONDecoder()
			.decode(MaybeArray<GroceryProduct>.self, from: json)
			.elements
			XCTAssertTrue(products.isEmpty)
		} catch {
			print(error)
		}
	}
	func testMaybeArrayWithOnlyWrong() {
		let json = #"""
			[
		    {
		        "points": 200,
		        "description": "A banana grown in Ecuador."
		    }
		]
		"""#.data(using: .utf8)!
		do {
			let products = try! JSONDecoder()
				.decode(MaybeArray<GroceryProduct>.self, from: json)
				.elements
			XCTAssertEqual(0, products.count)
		}
	}
}

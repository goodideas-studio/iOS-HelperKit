//
//  ArrayTests.swift
//  GISHelperKitTests
//
//  Created by 游宗諭 on 2019/11/17.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import XCTest
import GISHelperKit

class ArrayTests: XCTestCase {
	
	func testRotate() {
		let resource =
			[
				[0, 1, 2, 3],
				[4, 5, 6, 7]
		]
		let expect =
			[
				[0, 4],
				[1, 5],
				[2, 6],
				[3, 7]
		]
		
		XCTAssertEqual(expect, rotate(resource))
		let resource2 =
			[
				[0, 1, 2, 3],
				[4, 5, 6]
		]
		let expect2 =
			[
				[0, 4],
				[1, 5],
				[2, 6],
				[3]
		]
		
		XCTAssertEqual(expect2, rotate(resource2))
		let resource3 =
			[
				[0, 1, 3],
				[4, 5, 6, 7],
				[8]
		]
		let expect3 =
			[
				[0, 4, 8],
				[1, 5],
				[3, 6],
				[7]
		]
		
		XCTAssertEqual(expect3, rotate(resource3))
	}
	struct ZippedForSortingTest: Comparable {
		static func == (lhs: ZippedForSortingTest, rhs: ZippedForSortingTest) -> Bool { lhs.i == rhs.i }
		
		static func < (lhs: ZippedForSortingTest, rhs: ZippedForSortingTest) -> Bool { lhs.i < rhs.i}
		var i: Int
		var c: String
		init(i: Int) {
			self.i = i
			self.c = "a"
		}
	}
	func testArraySortingByKeyPath() {
		
		var zipedArray = (0...9).reversed().map(ZippedForSortingTest.init)
		zipedArray.sort(keyPath: \.i)
		let expect = (0...9).map(ZippedForSortingTest.init)
		XCTAssertEqual(zipedArray, expect)
		let expectReversed = Array(expect.reversed())
		let zippedReversed = expect.sorted(keyPath: \.i, ascending: false)
		XCTAssertEqual(expectReversed, zippedReversed)
	}
	func testMapByKeyPath() {
		let expert = (0...9).map {$0}
		let sample = expert.map(ZippedForSortingTest.init)
		let result = sample.map(\.i)
		XCTAssertEqual(expert, result)
	}
	func testReduceByKeyPath() {
		let sample = (0...9).map(ZippedForSortingTest.init)
		let expect = sample.reduce(0) {$0 + $1.i}
		let result = sample.reduce(keyPath: \.i, 0, +)
		XCTAssertEqual(expect, result)
	}
	
	func testFlatMap() {
		let list = (0...10).map({Array(repeating: $0, count: $0)})
		let expect = list.flatMap({$0})
		let result = list.flatMap(\.self)
		XCTAssertEqual(expect
			, result)
	}
	
	func testForEachM() {
		var array = [1, 2, 3, 4]
		let expect = array.map({$0*2})
		array.forEachM({$0*=2})
		XCTAssertEqual(expect, array)
	}
	
	func testRemoveDuplicate() {
		let array = [4, 4, 1, 1, 2, 2, 3, 3]
		let expect = [4, 1, 2, 3]
		let result = array.removeDuplicate()
		XCTAssertEqual(expect, result)
	}
}

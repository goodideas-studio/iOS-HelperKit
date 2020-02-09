//
//  GISHelperKitTests.swift
//  GISHelperKitTests
//
//  Created by 游宗諭 on 2019/9/6.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import XCTest
import GISHelperKit

class HelperKitTests: XCTestCase {

    func testSubArray() {
        let array = [0, 1, 2, 3, 4]
        XCTAssertEqual(4, array.subArray(range: 0...3).count)
        XCTAssertEqual(2, array.subArray(range: 0...1).count)
        XCTAssertEqual(1, array.subArray(range: 0...0).count)
        let array2 = [0]
        XCTAssertEqual(1, array2.subArray(range: 0...3).count)
        XCTAssertEqual(1, array2.subArray(range: 0...1).count)
        XCTAssertEqual(1, array2.subArray(range: 0...0).count)
    }
    func testSubArrayOfKey() {
        let s = ["s1", "s2", "s3"]
        let index = 2
        let key = s[index]
        let subs = s.subArray(where: {$0 == key})
        XCTAssert(s.subArray(range: 0...index) == subs)
        XCTAssert(s.subArray(where: {$0 == ""}) == [])

    }

    func testArraySafe() {
        let list = [1, 2]
        var index = 3
        let output = list.safe[index]
        XCTAssertNil(output)
        index = 1
        XCTAssertEqual(list[index], list.safe[index])
    }
}

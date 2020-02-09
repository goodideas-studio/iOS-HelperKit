//
//  DateTests.swift
//  GISHelperKitTests
//
//  Created by 游宗諭 on 2019/12/16.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import XCTest
import GISHelperKit

class DateTests: XCTestCase {
	func testDateTracker() {
		let msTracker = MillisecondTracker()
		sleep(1)
		dump(msTracker.diffTime)
	}
}

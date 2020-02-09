//
//  Int+Double+.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/12/5.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

extension Int {
	public func commaString() -> String? {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .decimal
		numberFormatter.groupingSize = 3
		return numberFormatter.string(from: NSNumber(value: self))
	}
	static var factorialList: [Int: Int] = [:]
	public func factorial() -> Self? {
		var tmp = self
		guard tmp >= 0 else {return nil}
		if tmp == 0 {
			return 1
		}
		if tmp == 1 {
			return 1
		}
		if let cache = Self.factorialList[self] {
			return cache
		}
		var result = 1
		while tmp > 1 {
			let multipliedReport = result.multipliedReportingOverflow(by: tmp) // check overflow
			if multipliedReport.overflow { // trigger early return
				return nil
			}
			result = multipliedReport.partialValue
			tmp -= 1
		}
		Self.factorialList[self] = result
		return result
	}
}

extension Double {
	public func commaString(floatPointPosition: Int? = nil) -> String? {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .decimal
		numberFormatter.groupingSize = 3
		var toFormatterDouble = self
		if let postion = floatPointPosition {
			let x = pow(10, Double(postion))
			toFormatterDouble =  (self * x).rounded() / x
		}
		return numberFormatter.string(from: NSNumber(value: toFormatterDouble))
	}
	public func floored(toPosition positon: Int) -> Double {
		let x = pow(10, Double(positon))
		return floor(self * x) / x
	}
}

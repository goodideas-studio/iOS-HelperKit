//
//  Date+.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/12/3.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

extension Date {
	public var jsDate: TimeInterval {self.timeIntervalSince1970}
	public func str(format: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		return formatter.string(from: self)
	}
	public var month: String {
		let locale = Locale.preferredLanguages[0]
		let formatter = DateFormatter()
		//    formatter.locale = NSLocale.current
		formatter.locale = Locale.init(identifier: locale)
		formatter.setLocalizedDateFormatFromTemplate("MMMM")
		return formatter.string(from: self)
	}
	public var monthDays: Range<Int> {
		return Calendar.current.range(of: .day, in: .month, for: self)!
	}
	public var monthDay: Int {
		return Calendar.current.component(.day, from: self)
	}
	public var weekDay: Int {
		return Calendar.current.component(.weekday, from: self)  - 1
	}
	public var firstDayofMonth: Date {
		var componets = Calendar.current.dateComponents( [.year, .month], from: self)
		componets.day = monthDays.lowerBound
		return Calendar.current.date(from: componets)!
	}
	public static
		func makeTheDate(month: Int, day: Int, year: Int, hour: Int = 0, minute: Int = 0) -> Date? {
		let calendar = Calendar.current

		var components = DateComponents()

		components.day = day
		components.month = month
		components.year = year
		components.hour = hour
		components.minute = minute

		return calendar.date(from: components)
	}
	public func addDate(_ days: Int) -> Date? {
		Calendar.current.date(byAdding: .day, value: days, to: self)
	}
 }
public
struct MillisecondTracker {
	public let startDate = Date()
	public init() { }
	public var diffTime: TimeInterval {Date().timeIntervalSince(startDate)*1_000}
}

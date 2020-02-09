//
//  HTMLCore.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2020/1/8.
//  Copyright © 2020 ytyubox. All rights reserved.
//

#if canImport(UIKit)

import UIKit
public
struct HTMLCore: ExpressibleByStringLiteral {
	
	private let html: String
	public let attributedString: NSAttributedString?
	public init(html: String) {
		self.html = html

		guard let data = html.data(using: .utf8) else {
			self.attributedString = nil
			return
		}
		do {
			let options: NSAttributedString.Options = [
				.documentType: NSAttributedString.DocumentType.html,
				.characterEncoding: String.Encoding.utf8.rawValue
			]
			attributedString = try NSAttributedString(data: data,
													  options: options,
													  documentAttributes: nil)
		} catch {
			attributedString = nil
		}
	}
	public init(stringLiteral html: String) { self.init(html: html) }
	public var plainText: String? {
		return attributedString?.string.trimmingCharacters(in: .newlines)
	}
	public
	func unsafeQuoteString(seperator: Character) -> [String] {
		var array: [Substring] = []
		var rangedString = html[html.startIndex...]

		while true {
			guard let index = rangedString.firstIndex(of: seperator) else { break }
			let next = html.index(after: index)
			if let nextIndex = html[next...].firstIndex(of: seperator) {
				let preIndex = html.index(before: nextIndex)
				array.append(html[next...preIndex])
				let afterIndex = html.index(after: nextIndex)
				rangedString = html[afterIndex...]
				continue
			}
			rangedString = html[next...]
		}

		return array.map(String.init)
	}
}

extension NSAttributedString {
	public
	typealias Options = [NSAttributedString.DocumentReadingOptionKey: Any]
}

#endif

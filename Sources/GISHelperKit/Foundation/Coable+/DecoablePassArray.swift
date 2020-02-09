//
//  DecoablePassArray.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2020/1/3.
//  Copyright © 2020 ytyubox. All rights reserved.
//

import Foundation
public
struct MaybeArray<Element: Decodable>: Decodable {
	public
	var elements: [Element]
	public
	var lastDeCodeError: Error?

	public init(from decoder: Decoder) throws {

		var container = try decoder.unkeyedContainer()

		var elements = [Element]()
		if let count = container.count {
			elements.reserveCapacity(count)
		}

		while !container.isAtEnd {
			let element = try container.decode(FailableDecodable<Element>.self)
			if let base = element.base {
				elements.append(base)
			} else {
				lastDeCodeError = element.thisError
			}

		}
		self.elements = elements
	}
}

struct FailableDecodable<Base: Decodable>: Decodable {

	let base: Base?
	let thisError: Error!
	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		do {
		self.base = try container.decode(Base.self)
			self.thisError = nil
		} catch {
			self.base = nil
			self.thisError = error
		}
	}
}

//
//  URL+.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/11/26.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

extension URL {
	public
	var parameters: [String: String]? {
		guard
			let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
			let queryItems = components.queryItems
			else {return nil}
		var parameters = [String: String]()
		for item in queryItems {
			parameters[item.name] = item.value ?? ""
		}
		return parameters
	}
}

extension URL: ExpressibleByStringLiteral {
	public init(stringLiteral value: String) {
		self = URL(string: value)!
	}
}

//
//  Codable+.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/8/29.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation
public
protocol Encoded {
	var encoded: Data? {get}
}

extension Encodable where Self: Encoded {
    public var encoded: Data? {
        return try? JSONEncoder().encode(self)
    }
    public var prettyString: NSString? {
        let data = encoded
        return data?.prettyPrintedJSONString
    }
}

public
extension Encoded where Self: Encodable {
	var map: [String: String]? {
		guard
			let data = try? JSONEncoder().encode(self),
			let map = try? JSONDecoder().decode([String: String].self, from: data)
			else {return nil}
		return map
	}
}

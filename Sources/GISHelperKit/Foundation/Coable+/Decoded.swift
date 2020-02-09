//
//  Decoded.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2020/1/13.
//  Copyright © 2020 ytyubox. All rights reserved.
//

import Foundation

public
protocol Decoded {
	associatedtype Agent: DecodeAgent
	static var agent: Agent {get}
	init(from decoder: Decoder) throws
	static func makeObject(data: Data) throws ->Self
}

extension Decodable where Self: Decoded {
	static func makeObject(data: Data) throws ->Self {
		try Self.agent.decode(Self.self, from: data)
	}
}

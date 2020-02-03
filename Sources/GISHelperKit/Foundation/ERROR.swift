//
//  ERROR.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/12/2.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation
public
struct ERROR: Error {

	public let message: String
	public init(_ m: String) {
		message = m
	}
}

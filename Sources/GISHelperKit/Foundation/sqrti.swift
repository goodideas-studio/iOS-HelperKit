//
//  File.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/11/14.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation
/// get square root of an int, if the result is not ration number, return nearest Int
/// - Parameter i: the number to compute
public
func sqrti(_ i: Int) -> Int {
    Int(sqrt(Double(i)))
}

//
//  Double+FormatString.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/10/9.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

public extension Double {
    var str: String {
        var str = self.description
        while str.last == "0" || str.last == "." {
            str.removeLast()
        }
        return str
    }
}

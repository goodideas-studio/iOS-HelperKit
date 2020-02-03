//
//  Query.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/11/1.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation
public
protocol Queryed {
    var queryDic: [String: String] {get}
}
public
struct Query {
    public var info: [String: String]
}

extension Query: Encoded {
    public var encoded: Data? {
        return nil
    }
}

extension Query: Queryed {
    public var queryDic: [String: String] { info }
}

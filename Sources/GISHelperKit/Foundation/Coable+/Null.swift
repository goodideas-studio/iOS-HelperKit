//
//  Null.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/9/3.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

public
struct EmptyJSON: Codable {
    public init?() {
        return nil
    }
}

extension EmptyJSON: CustomStringConvertible {
    public var description: String {
        return "Null"
    }

}
extension EmptyJSON: Encoded {

}
extension EmptyJSON: Queryed {
    public var queryDic: [String: String] {[:]}
}
public
struct Null: Decodable {

}

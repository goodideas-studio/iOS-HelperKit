//
//  CodeAgent.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/10/31.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

public
protocol DecodeAgent {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}
public protocol EncodeAgent {
    func encode<T>(_ value: T) throws -> Data where T: Encodable
}
extension JSONDecoder: DecodeAgent {
}

extension JSONEncoder: EncodeAgent {
}

extension PropertyListEncoder: EncodeAgent {

}
extension PropertyListDecoder: DecodeAgent {

}

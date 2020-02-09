//
//  File.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/8/26.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

extension Data {
    public var str: String? {
        return String(data: self, encoding: .utf8)
    }
    public var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

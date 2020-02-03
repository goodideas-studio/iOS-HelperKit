//
//  JSONStringfy.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/11/1.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import JavaScriptCore
public
struct JSONStringfy {
    private let jsContext = JSContext()

    public var code: String?
    public init(jsObject: String = "") {
        self.code = jsObject
    }
    public
    func stringified() -> String? {
        guard
            let code = self.code else {
				return nil
		}
        return stringifed(for: code)
    }
    public func stringifed(for code: String) -> String? {
               let objcetName = "json"
               let c = """
               var p = \(code)
               var \(objcetName) = JSON.stringify(p)
               """
               jsContext?.evaluateScript(c)
               let object = jsContext?.objectForKeyedSubscript(objcetName)
               let str = object?.toString()
		if str == "undefined" {
			return nil
		}
		return str
    }
}

//
//  Dictionary+.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/8/26.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation
public
extension Dictionary {
    /// replace key value for lhr if lhr and rhr have the same key
    /// += operater is problematic, using let new = l + r instade
     static func +(lhr: Dictionary<Key, Value>, rhr: Dictionary<Key, Value>)  -> Dictionary<Key, Value> {
        var copied = lhr
        for (k, v) in rhr {
            copied[k] = v
        }
        return copied
    }
     static func +(lhr: Dictionary<Key, Value>?, rhr: Dictionary<Key, Value>)  -> Dictionary<Key, Value> {
        guard var copied = lhr else { return rhr}
        for (k, v) in rhr {
            copied[k] = v
        }
        return copied
    }
	subscript(fi key: Key, ifNot defaultValue: Value ) -> Value {
		get {
			self[key] ?? (defaultValue)
		}
	}
	subscript(fi key: Key) -> Value? {
		get {
			self[key]
		}
	}
}
public
extension Dictionary where Key == Value {
	subscript(if key: Key, ifNot defaultValue: Value? ) -> Value {
		get {
			self[key] ?? (defaultValue ?? key)
		}
	}
//	subscript(if key: Key) -> Value {
//		get {
//			self[key] ?? key
//		}
//	}
    subscript(if _key: Key?) -> Value? {
        get {
            guard let key = _key else {return _key}
            return self[key] ?? key
        }
    }
}

extension Dictionary where Key  == String, Value == String {
    public var query: String {
        let qlist = reduce([]) { $0 + [URLQueryItem(name: $1.key, value: $1.value)] }
        var r = URLComponents()
        r.queryItems = qlist
        return r.query!
    }
	public
	func niceDump(_ prefix: String = "", if keyPath: KeyPath<Dictionary, Bool> = \.isEmpty.not) {
		let b =	self[keyPath: keyPath]
		guard b
			else {return}
		print([prefix, "["].filter(\.isEmpty.not).joined(separator: " "))
		let s = self.sorted(by: {$0.key < $1.key}).map {"  \"\($0.key)\": \"\($0.value)\""}.joined(separator: ",\n")
		print(s)
		print("]")
	}
}

extension Dictionary where Key == String {
    public var array: [Value] {
        return sorted {$0.0 < $1.0}.map {$0.value}
    }
}

extension URLRequest {
    public
    mutating func addQuery(with dic: [String: String]) {
        var copiedurl = URLComponents(string: url!.absoluteString)
        if let o = copiedurl?.query {
            copiedurl!.query = o + dic.query
        } else {
            copiedurl!.query = dic.query
        }
        url = copiedurl?.url
    }
}

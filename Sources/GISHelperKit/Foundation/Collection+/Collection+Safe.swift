//
//  Collection+Safe.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/9/20.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

public struct Safe<Base> where Base: Collection {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }

    public subscript(_ index: Base.Index) -> Base.Element? {
        if !base.indices.contains(index) {
            return nil
        }
        return base[index]
    }
}
public extension Collection {
    var safe: Safe<Self> {
        return Safe(self)
    }
	func reduce<ToReduce, Result>(keyPath: KeyPath<Element, ToReduce>,
							  _ initialResult: Result,
							  _ nextPartialResult: (Result, ToReduce) throws -> Result) rethrows -> Result {
		try self.reduce(initialResult) { (r, e) in
			return try nextPartialResult(r, e[keyPath:keyPath])
		}
	}
	__consuming func combo(byCount count: Int) -> [[Element]] {
		let copy = Array(self)
		if(self.count == count) { return [copy] }
		if(self.isEmpty) { return [] }
		if(count == 0) { return [] }
		if(count == 1) { return self.map { [$0] } }

		var result: [[Element]] = []

		let rest = Array(copy.suffix(from: 1))

		let subCombos = rest.combo(byCount: count - 1)
		result += subCombos.map { [copy[0]] + $0 }
		result += rest.combo(byCount: count)
		return result
	}

}

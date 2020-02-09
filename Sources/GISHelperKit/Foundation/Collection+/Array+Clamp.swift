//
//  Array+Clamp.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/9/6.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

extension Comparable {
    public func clamp(for range: ClosedRange<Self>) -> Self {
        return max(range.lowerBound, min(range.upperBound, self))
    }
}

extension Array {
    public func subArray(range: ClosedRange<Int>) -> Array<Element> {
        guard count > 0 else {return []}
        let newLower = range.lowerBound.clamp(for: 0...count-1)
        let newUpper = range.upperBound.clamp(for: 0...count-1)
        return Array(self[newLower...newUpper])
    }
    public func group<Key: Hashable>(by keyForValue: (Element) throws -> Key) rethrows -> Dictionary<Key, Self> {
       try Dictionary(grouping: self, by: keyForValue)
    }
    public func group<Key: Hashable>(by: KeyPath<Element, Key>) -> Dictionary<Key, Self> {
        Dictionary(grouping: self) { $0[keyPath: by] }
    }
}

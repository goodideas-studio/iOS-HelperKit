//
//  Array+subarray(ofkey) .swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/9/17.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

extension Array
//where Element:Equatable
{
    @inlinable public
    func subArray(where predicate: (Array.Element) throws -> Bool) rethrows -> [Element] {
        guard let index = try firstIndex(where: predicate)
            else {
            return []
        }
        return subArray(range: 0...index)
    }
}

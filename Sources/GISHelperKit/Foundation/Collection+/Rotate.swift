//
//  Rotate.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/11/17.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation
/// Rotate a 2d array with right direction
/// - Parameter array: the array to rotate, don't need to  full
public
func rotate<T>(_ array: [[T]]) -> [[T]] {
    var result = [[T]]()
    let maxCount = array.reduce(0) {max($0, $1.count)}
    for y in 0..<maxCount {
        var layer = [T]()
        for x in array.indices {
            if let it = array[safeIndex: x]?[safeIndex: y] {
                layer.append(it)
            }
        }
        result.append(layer)
    }
    return result
}
public
enum Direction {
    case left, right
}

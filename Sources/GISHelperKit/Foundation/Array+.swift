//
//  Array+Safe.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/10/31.
//  Copyright © 2019 ytyubox. All rights reserved.
//
import Foundation
extension Array {
	/// [GISHelper] 安全的取得指定 index 的 element, 若是 out of range, 則 return default value
	public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
		guard index >= 0, index < endIndex else {
			return defaultValue()
		}

		return self[index]
	}
	/// [GISHelper] 安全的取得指定 index 的 element, 若是 out of range, 則 return nil
	public subscript(safeIndex index: Int) -> Element? {
		guard index >= 0, index < endIndex else {
			return nil
		}

		return self[index]
	}
	/// [GISHelper] 安全的取得指定 index 的 element, 若是 out of range 則 throw Error
    public func safeIndex(_ index: Int, errorPrefix: String = "") throws -> Element {
        guard let r = self[safeIndex: index] else {
            throw ERROR(errorPrefix + " \(index) out of range")
        }
        return r
    }
	///[GISHelper] 透過Element指定的 KeyPath 執行 mutating 排序
	/// Sorts the collection in place, using the given KeyPath  as the comparison between elements.
	/// - Parameters:
	///   - keyPath: keyPath for sorting Key,  Comparable is required.
	///   - ascending: true for lowest  first, default to true.
	///   - Complexity: O(n log n), where n is the length of the collection.
	public mutating func sort<Key: Comparable>(keyPath: KeyPath<Element, Key>, ascending: Bool = true) {
		if ascending {
			self.sort { (pre, post) -> Bool in
				pre[keyPath: keyPath] < post[keyPath: keyPath]
			}
		} else {
			self.sort { (pre, post) -> Bool in
				pre[keyPath: keyPath] > post[keyPath: keyPath]
			}
		}
	}

	/// [GISHelper] 透過Element指定的 KeyPath排序, 並 return 結果
	/// Returns the elements of the sequence, sorted using the given predicate as the comparison between elements.
	/// - Parameters:
	///   - keyPath: keyPath for sorting Key, Comparable is required.
	///   - ascending: true for lowest  first, default to true.
	///   - Complexity: O(n log n), where n is the length of the collection.
	public func sorted<Key: Comparable>(keyPath: KeyPath<Element, Key>, ascending: Bool = true) -> [Element] {
		if ascending {
			return self.sorted { (pre, post) -> Bool in
				pre[keyPath: keyPath] < post[keyPath: keyPath]
			}
		} else {
			return	self.sorted { (pre, post) -> Bool in
				pre[keyPath: keyPath] > post[keyPath: keyPath]
			}
		}
	}
	/// [GISHelper] 將 每個 Element 轉變為指定的 KeyPath 並 return 轉變後的 Array
	/// Returns an array containing the results of mapping the given closure over the sequence’s elements
	/// - Parameter keyPath: keyPath for transformed value of the Element.
	public func map<Key>(_ keyPath: KeyPath<Element, Key>) -> [Key] {
		map {$0[keyPath: keyPath]}
	}
    /// [GISHelper] 透過Element指定的 KeyPath 執行 array 的 flat 並回傳
	/// Returns an array containing the concatenated results of calling the
    /// given transformation with each element of this sequence.
    ///
    /// Use this method to receive a single-level collection when your
    /// transformation produces a sequence or collection for each element.
    ///
    /// In this example, note the difference in the result of using `map` and
    /// `flatMap` with a transformation that returns an array.
    ///
    ///     let numbers = [1, 2, 3, 4]
    ///
    ///     let mapped = numbers.map { Array(repeating: $0, count: $0) }
    ///     // [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]
    ///
    ///     let flatMapped = numbers.flatMap(\.self)
    ///     // [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
    ///
    /// In fact, `s.flatMap(transform)`  is equivalent to
    /// `Array(s.map(transform).joined())`.
    ///
    /// - Parameter transform: A closure that accepts an element of this
    ///   sequence as its argument and returns a sequence or collection.
    /// - Returns: The resulting flattened array.
    ///
    /// - Complexity: O(*m* + *n*), where *n* is the length of this sequence
    ///   and *m* is the length of the result.
	public func flatMap<SegmentOfResult>(_ keyPath: KeyPath<Element, SegmentOfResult>) -> [SegmentOfResult.Element] where SegmentOfResult: Sequence {
		flatMap { $0[keyPath: keyPath]}
	}
	/// [GISHelper] 使用 forEach mutating Element
	///
	/// before
	/// ```swift
	/// let array = [1, 2, 3, 4]
	///
	///	for index in array.indices {
	/// 	array[index] *= 2
	/// }
	/// // array = [2, 4, 6, 8]
	/// ```
	///
	/// after
	///```swift
	///let array = [1, 2, 3, 4]
	///array.forEachM{$0*2}
	///
	///// array = [2, 4, 6, 8]
	///```
	///
	/// - Parameter mutator: a closure
	public mutating func forEachM(_ mutator: (inout Element) throws -> Void) rethrows {
		for index in indices {
			try mutator(&self[index])
		}
	}
	/// [GISHelper] return KeyPath Bool 為 True 的 array
	/// - Parameter keyPath: the Bool KeyPath for condition
	public func filter(_ keyPath: KeyPath<Element, Bool>) -> [Element] {
		filter {$0[keyPath: keyPath]}
	}
	
    /// 將 Element 轉化為 KeyPath value, return 排除 nil 之後的 array
    ///
    ///
    /// Use this method to receive an array of non-optional values when your
    /// transformation produces an optional value.
    ///
    /// In this example, note the difference in the result of using `map` and
    /// `compactMap` with a transformation that returns an optional `Int` value.
    ///
    ///     let possibleNumbers = ["1", "2", "three", "///4///", "5"]
    ///
    ///     let mapped: [Int?] = possibleNumbers.map { str in Int(str) }
    ///     // [1, 2, nil, nil, 5]
    ///
    ///     let compactMapped: [Int] = possibleNumbers.compactMap(\.self)
    ///     // [1, 2, 5]
    ///
    /// - Parameter keypath: A KeyPath for an optional value.
    /// - Returns: An array of the non-`nil` of the keyPath value
    ///   with each element of the sequence.
    ///
    /// - Complexity: O(*m* + *n*), where *n* is the length of this sequence
    ///   and *m* is the length of the result.
	public func compactMap<Key>(_ keyPath: KeyPath<Element, Key?>) -> [Key] {
		compactMap {$0[keyPath: keyPath]}
	}
	public func first(_ keyPath: KeyPath<Element, Bool>) -> Element? {
		first {$0[keyPath: keyPath]}
	}

    public func first(_ keyPath: KeyPath<Element, Bool?>) -> Element? {
        first {$0[keyPath: keyPath] ?? false}
    }
    public func firstNil(_ keyPath: KeyPath<Element, Bool?>) -> Element? {
        first {$0[keyPath: keyPath] == nil}
    }
}

extension Array where Element: Equatable {
    public func removeDuplicate() -> [Element] {
          reduce(into: [Element]()) {
              if $0.contains($1) {
                  return
              }
              $0.append($1)
          }
      }

}
public
extension Bool {
	/// [GISHelper]  方便取得反向的鏈式調用, 可用於 KeyPath
    var not: Bool {!self}
}

extension Array where Element == Maybe {
	public func safeIndex<Output>(_ index: Int, as keyPath: KeyPath<Maybe, Output?>, errorPrefix: String = "") throws -> Output {
		guard let r = self[safeIndex: index] else {
			throw ERROR(errorPrefix + " \(index) out of range")
		}
		guard let output = r[keyPath: keyPath] else {
			throw ERROR("\(Self.self) \(index) expect \(Output.self), but found \(r)")
		}
		return output
	}
	public func safeIndex<Output>(_ index: Int, nil keyPath: KeyPath<Maybe, Output?>, errorPrefix: String = "") throws -> Output? {
		guard let r = self[safeIndex: index] else {
			throw ERROR(errorPrefix + " \(index) out of range")
		}
		return r[keyPath: keyPath]
	}
}

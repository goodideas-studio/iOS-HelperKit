//
//  Array+Safe.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/10/31.
//  Copyright © 2019 ytyubox. All rights reserved.
//

extension Array {
	public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
		guard index >= 0, index < endIndex else {
			return defaultValue()
		}

		return self[index]
	}
	public subscript(safeIndex index: Int) -> Element? {
		guard index >= 0, index < endIndex else {
			return nil
		}

		return self[index]
	}
    public func safeIndex(_ index: Int, errorPrefix: String = "") throws -> Element {
        guard let r = self[safeIndex: index] else {
            throw ERROR(errorPrefix + " \(index) out of range")
        }
        return r
    }
	/// Sorts the collection in place, using the given KeyPath  as the comparison between elements.
	/// - Parameters:
	///   - keyPath: keyPath for sorting Key
	///   - ascending: true for lowest  first, default to ture
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

	/// Returns the elements of the sequence, sorted using the given predicate as the comparison between elements.
	/// - Parameters:
	///   - keyPath: keyPath for sorting Key
	///   - ascending: true for lowest  first, default to ture
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
	/// Returns an array containing the results of mapping the given closure over the sequence’s elements
	/// - Parameter keyPath: keyPath for transformed value of the Element.
	public func map<Key>(_ keyPath: KeyPath<Element, Key>) -> [Key] {
		map {$0[keyPath: keyPath]}
	}

	public func flatMap<SegmentOfResult>(_ keyPath: KeyPath<Element, SegmentOfResult>) -> [SegmentOfResult.Element] where SegmentOfResult: Sequence {
		flatMap { $0[keyPath: keyPath]}
	}
	public mutating func forEachM(_ body: (inout Element) throws -> Void) rethrows {
		for index in indices {
			try body(&self[index])
		}
	}
//	public func compactMap<Key>(_ keyPath: KeyPath<Element, Key>) -> [Key] {
//		compactMap {$0[keyPath: keyPath]}
//	}
	public func filter(_ keyPath: KeyPath<Element, Bool>) -> [Element] {
		filter {$0[keyPath: keyPath]}
	}
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

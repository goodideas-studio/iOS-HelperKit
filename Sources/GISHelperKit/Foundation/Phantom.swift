//
//  Phantom.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/12/11.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

/// limiting string to type safe
/// ```swift
/// enum TFDate {}
/// typealias DateString = PhamtomString<TFDate>
/// ```
///
public struct PhantomString<T>: Hashable, CustomStringConvertible {

	public var value: String
	public init(_ value: String) {
		self.value = value
	}
	public init(stringLiteral value: String) {
		self.value = value
	}
	public var description: String { value}

}

extension PhantomString: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		value = try container.decode(String.self)
	}
}

@propertyWrapper
public
struct Phantom<Phantomed, Value> {
	public var projectedValue: PhantomType<Phantomed, Value>
	public var wrappedValue: Value {projectedValue.value}
	public init(wrappedValue: Value) {
		self.projectedValue = .init(wrappedValue)
	}
}
extension Phantom: Equatable where Value: Equatable {

}
extension Phantom: Hashable where Value: Hashable & CustomStringConvertible {

}

@dynamicMemberLookup
public struct PhantomType<Phantom, Value> {
	public var value: Value
	public	init(_ value: Value) {
		self.value = value
	}
	public
	subscript<T>(
		dynamicMember keyPath: WritableKeyPath<Value, T>
	) -> T {
		get { value[keyPath: keyPath] }
		set { value[keyPath: keyPath] = newValue}

	}

}
extension PhantomType: Equatable where Value: Equatable {

}

extension PhantomType: Hashable, CustomStringConvertible where Value: Hashable & CustomStringConvertible {

	public var description: String {value.description}
}
extension PhantomType: Codable where Value: Codable {

}

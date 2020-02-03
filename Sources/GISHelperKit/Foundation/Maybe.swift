//
//  Maybe.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/11/26.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation
public
enum Maybe: Decodable {
	public typealias ListMaybe = [Maybe]
	public typealias DicMaybe = [String: Maybe]
	//    case int(Int)
	case double(Double)
	case string(String)
	case bool(Bool)
	case listMaybe(ListMaybe)
	case dicMaybe(DicMaybe)
	case null
	public
	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		//        if let x = try? container.decode(Int.self) { self = .int(x);return }
		if let x = try? container.decode(Double.self) { self = .double(x);return }
		if let x = try? container.decode(String.self) { self = .string(x);return }
		if let x = try? container.decode(Bool.self) { self = .bool(x) ;return }
		if let x = try? container.decode([String: Maybe].self) { self = .dicMaybe(x) ;return }
		if let x = try? container.decode([Maybe].self) { self = .listMaybe(x) ;return }
		if container.decodeNil() { self = .null; return }
		throw DecodingError.typeMismatch(Self.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type"))
	}
	public var int: Int! { guard case let .double(i) = self else { return nil }; return Int(i) }
	public var double: Double! {
		switch self {
		case .double(let i):	return i
		case .string(let i):	return Double(i)
		default:				return nil
		}
	}
	public var string: String! { guard case let .string(i) = self else { return nil }; return i }
	public var bool: Bool! { guard case let .bool(i) = self else { return nil }; return i }
	public var dic: DicMaybe! { guard case let .dicMaybe(i) = self else { return nil }; return i }
	public var array: ListMaybe! { guard case let .listMaybe(i) = self else { return nil }; return i }
	public var _2DArray: [ListMaybe]! { guard case let .listMaybe(i) = self else { return nil }; return i.map {$0.array} }
	public func convent<D>(to type: D.Type) throws -> D where D: Decodable {
		guard case let .dicMaybe(dic) = self else {fatalError()}
		let data = try JSONEncoder().encode(dic)
		return try JSONDecoder().decode(type, from: data)

	}
	public func map<Value, Output>(by keyPath: KeyPath<Maybe, Value>, _ transform: (Value) throws -> Output) rethrows -> Output {
		let value = self[keyPath: keyPath]
		return try transform(value)
	}
}

extension Maybe: CustomStringConvertible {
	public
	var description: String {
		switch  self {
		case .double(let s): return s.description
		case .string(let s): return s.description
		case .bool(let s): return s.description
		case .listMaybe(let s): return s.description
		case .dicMaybe(let s): return s.description
		case .null: return "nil"
		}
	}
}

extension Maybe: Encodable {
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		switch self {
		case .double(let x): try container.encode(x)
		case .string(let x): try container.encode(x)
		case .bool(let x): try container.encode(x)
		case .listMaybe(let x): try container.encode(x)
		case .dicMaybe(let x): try container.encode(x)
		case .null: break
		}
	}
}

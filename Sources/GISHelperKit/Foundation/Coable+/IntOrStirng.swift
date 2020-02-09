//
//  IntOrStirng.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/8/26.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

public
enum ShareIntORSting: Codable {
    case integer(Int)
    case string(String)
    public var string: String {
        switch self {
        case .integer(let i): return i.description
        case .string(let s): return s
        }
    }
    public var number: Int {
        switch self {
        case .integer(let i): return i
        case .string(let s): return Int(atoi(s))
        }
    }
    public
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ShareIntORSting.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ShareIntORSting"))
    }
    public
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

public
enum ShareDoubleORSting: Codable {
    case double(Double)
    case string(String)
    public var string: String {
        switch self {
        case .double(let i): return String(format: "%.2f", i)
        case .string(let s): return s
        }
    }
    public var number: Double {
        switch self {
        case .double(let i): return i
        case .string(let s): return Double(s)!
        }
    }
    public
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ShareIntORSting.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ShareDoubleORSting"))
    }
    public
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
public
enum ShareOR<T: Codable>: Codable {
    case t(T)
    case string(String)
    public var string: String {
        switch self {
        case .t(let i): return "\(i)"
        case .string(let s): return s
        }
    }
    public
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(T.self) {
            self = .t(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ShareIntORSting.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ShareOR<T>"))
    }
    public
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .t(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

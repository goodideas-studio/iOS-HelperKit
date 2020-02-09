//
//  APIEndpoint.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/8/26.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation
public
protocol LikeAPIEndPoint {
    associatedtype Body: Encoded & Queryed
    associatedtype Success: Decodable
    associatedtype Failure: Decodable
    #if DEBUG
    var mock: Success {get}
    #endif
    var apiList: APINameSpace.Type {get}
    var endpoint: String {get}
    var header: [String: String] {get}
    var body: Body! {get}
    var httpMethod: HttpMethod {get}
    var contentType: ContentType? {get}
    var s: Success? {get}
    var f: Failure? {get}
    var SuccessType: Success.Type {get}
    var FailureType: Failure.Type {get}
    var baseQueryDic: [String: String]? {get}

    init(endpoint: String,
         httpMethod: HttpMethod,
         contentType: ContentType?,
         apiList: APINameSpace.Type)
    var request: URLRequest {get}
}

public
struct APIEndPoint<Body: Encoded & Queryed, Success: Decodable, Failure: Decodable>: LikeAPIEndPoint {
    #if DEBUG
    public var mock: Success {
        let data = mockSource.data(using: .utf8)!
        return try! JSONDecoder().decode(SuccessType, from: data)
    }
    public var mockSource: String = ""
    #endif
    public let SuccessType: Success.Type
    public let FailureType: Failure.Type
    public let apiList: APINameSpace.Type
    public let endpoint: String
    public var header = [String: String]()
    public var body: Body!
    public let httpMethod: HttpMethod
    public var contentType: ContentType?
    public let s: Success?
    public let f: Failure?
    public var baseQueryDic: [String: String]?

    public
    init(endpoint: String,
         httpMethod: HttpMethod,
         contentType: ContentType?,
         apiList: APINameSpace.Type) {
        self.endpoint = endpoint
        self.httpMethod = httpMethod
        self.contentType = contentType
        self.s = nil
        self.f = nil
        SuccessType = Success.self
        FailureType = Failure.self
        self.apiList = apiList
        #if DEBUG
        mockSource = ""
        #endif
    }
    public var request: URLRequest {
        apiList.makeRequest(for: self)
    }
}
public enum ContentType {
    init(_ contentType: ContentType, field: [String: String] = [:]) {
        self = contentType

    }
    case json
    case urlEncode
    case formData

    var rawValue: String {
        switch self {
        case .json: return "application/json; charset=UTF-8"
        case .urlEncode: return "application/x-www-form-urlencoded"
        case .formData: return ("⛔️ formdata need boundary for header")
        }
    }

    public func add(to request: inout URLRequest) {

        request.setValue(self.rawValue, forHTTPHeaderField: Self.headerKey)
    }
    static var headerKey: String {"Content-Type"}
}
public
enum HttpMethod: String {
    case GET, POST
}

//
//  Pr_APINameSpace.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/10/31.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

public
protocol APINameSpace {
    static var baseURL: String {get}
    static var urlTemplate: URLComponents {get}
    static func makeRequest<Body, Success, Fail>(for apiEnpoint: APIEndPoint<Body, Success, Fail>) -> URLRequest where Body: Queryed & Encoded, Success: Decodable, Fail: Decodable
    static var baseHeader: [String: String] {get}
}
public
extension APINameSpace {
    static var urlTemplate: URLComponents {URLComponents(string: Self.baseURL)!}
    static func makeRequest<Body, Success, Fail>(for api: APIEndPoint<Body, Success, Fail>) -> URLRequest  where Body: Queryed & Encoded, Success: Decodable, Fail: Decodable {
        var  url  = URLComponents(string: Self.baseURL)!
        url.path += api.endpoint
        let bodyQueryDic = api.body?.queryDic ?? [:]
        let queryDic = api.baseQueryDic + bodyQueryDic
        url.query = queryDic.query
        assert(url.url != nil)
        var request = URLRequest(url: url.url!)
        request.timeoutInterval = 15
        request.httpMethod = api.httpMethod.rawValue
        request.allHTTPHeaderFields = api.header
        request.allHTTPHeaderFields = Self.baseHeader
        api.contentType?.add(to: &request)
        if api.contentType == .formData, let body = api.body as? IsFormData {
			let formData = body.formData
			request.httpBody = formData.encoded
			request.allHTTPHeaderFields = request.allHTTPHeaderFields! + formData.headerfield
        } else {
			request.httpBody = api.body?.encoded
		}
        return request
    }
}

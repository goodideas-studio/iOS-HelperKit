//
//  URLSession+.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/8/26.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

extension URLSession {
    public typealias URLInfo = (data: Data?, response: URLResponse?)
    public func getData(with url: URL, timeout: TimeInterval = 15) throws -> URLInfo {
        let s = DispatchSemaphore(value: 0)
        var result: URLInfo = (nil, nil)
        var error: Error?
        dataTask(with: url) { (d, r, e) in
            error = e
            result.data = d
            result.response = r
            s.signal()
        }.resume()

        let some =  s.wait(timeout: .now()+timeout)
        switch some {
        case .success:
            break
        case .timedOut:
            throw APIError.timeout
        }
        if let error = error {
            throw error
        }
//        let thedata = result.data
        if result.data == nil || result.data!.isEmpty {
            throw APIError.noData
        }
        return result
    }

    public func getData(with request: URLRequest, timeout: TimeInterval = 15) throws -> URLInfo {
        let s = DispatchSemaphore(value: 0)
        var result: URLInfo = (nil, nil)
        var error: Error?
        dataTask(with: request) { (d, r, e) in
            error = e
            result.data = d
            result.response = r
            s.signal()
            }.resume()

        let some =  s.wait(timeout: .now()+timeout)
        switch some {
               case .success:
                   break
               case .timedOut:
                   throw APIError.timeout
               }
        if let error = error {
            throw error
        }
//        let thedata = result.data
        if result.data == nil || result.data!.isEmpty {
            throw APIError.noData
        }
        return result
    }

}

public
enum URLResult<Model: Decodable, Failure: Decodable, Err: Error> {
    case success(Model)
    case apiError(Failure)
    case failure(Err)
    case decodeError(APIError)
    case retry(Int)
	public var isSuccess: Bool {
		switch self {
		case .success: return true
		default: return false
		}
	}
}

public
enum APIError: Error {
    case timeout
    case noData
    case noResponse
    case JSONDecodeError
    case retryNumberRunout
	case other(String)
    public var localizedDescription: String {
        switch self {
        case .timeout: return "請求超時"
        case .noData: return "回传资料空"
        case .noResponse: break
        case .JSONDecodeError: break
        case .retryNumberRunout: return "重試請求超時"
		case .other(let s): return s
        }
        return "回传资料格式错误"
    }
}

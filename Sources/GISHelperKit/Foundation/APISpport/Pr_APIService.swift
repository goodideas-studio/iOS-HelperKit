//
//  APIServiceTemplate.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/10/31.
//  Copyright © 2019 ytyubox. All rights reserved.
//
import Foundation
public
protocol LikeAPIService {
	//    static var shared:Self { get }
	static var isDebug: Bool {get set}
	static var tempStr: String {get set}
	associatedtype DecodingAgent: DecodeAgent
	associatedtype EncodingAgent: EncodeAgent
	static var decoder: DecodingAgent {get}
	static var encoder: EncodingAgent {get}
	static func fetch<Body, Success, Fail> (from api: APIEndPoint<Body, Success, Fail>,
											onConfig: ((inout URLRequest) -> Void)?,
											retryCount: Int,
											retryPreJob:((()->Void)->Void)?,
											then: @escaping (URLResult<Success, Fail, Error>) -> Void) -> URLSessionTask
		where Body: Queryed & Encoded, Success: Decodable, Fail: Decodable
}

//public
//extension LikeAPIService {
//	static var session: URLSession {URLSession.shared}
//	static
//		func fetch<Body, Success, Fail> (from api: APIEndPoint<Body, Success, Fail>,
//										 onConfig: ((inout URLRequest) -> Void)?,
//										 retryCount: Int,
//										 retryPreJob:((()->Void)->Void)?,
//										 then: @escaping (URLResult<Success, Fail, Error>) -> Void) -> URLSessionTask
//		where Body: Queryed & Encoded, Success: Decodable, Fail: Decodable {
//			var request = api.apiList.makeRequest(for: api)
//			onConfig?(&request)
//			let task = session.dataTask(with: request) { (data, reponse, error) in
//				let isDebug = self.isDebug
//				var result: URLResult<Success, Fail, Error>
//				defer {
//					DispatchQueue.main.async { then(result)}
//				}
//				if let error = error {
//					return result = .failure(error)
//				}
//
//				guard let hr = reponse as? HTTPURLResponse else {
//					return result = .failure(APIError.noResponse)
//
//				}
//
//				guard
//					let data = data,
//					let str = String(data: data, encoding: .utf8) else {
//						return result = .decodeError(APIError.noData)
//				}
//				if str.isEmpty || !str.contains("{") {
//					guard retryCount > 0 else {result = .failure(APIError.retryNumberRunout);return}
//					retryPreJob?({
//						_ = self.fetch(from: api,
//									   onConfig: onConfig,
//									   retryCount: retryCount - 1,
//									   retryPreJob: retryPreJob,
//									   then: then)
//					})
//					return result = .retry(retryCount)
//				}
//				Self.tempStr = "\(data.prettyPrintedJSONString!)"
//				do {
//					let model = try Self.decoder.decode(Success.self, from: data)
//					return result = .success(model)
//				} catch let sError {
//					if isDebug {
//						dprint(sError)
//						print(hr.url!)
//						print("data: ")
//						print(data.prettyPrintedJSONString ?? "No data")
//					}
//				}
//
//				do {
//					let apiFail = try Self.decoder.decode(Fail.self, from: data)
//					result = .apiError(apiFail)
//				} catch let decodeError {
//					result = .decodeError(APIError.JSONDecodeError)
//					if isDebug {
//						dprint(decodeError)
//					}
//				}
//
//			}
//			DispatchQueue.global().async {
//				task.resume()
//			}
//			return task
//	}
//}
public
protocol FLikeAPIService {
	//    static var shared:Self { get }
	var isDebug: Bool {get set}
	var tempStr: String {get set}
	var session: URLSession {get}
	associatedtype DecodingAgent: DecodeAgent
	associatedtype EncodingAgent: EncodeAgent
	var decoder: DecodingAgent {get}
	var encoder: EncodingAgent {get}
	init(decoder: DecodingAgent, encoder: EncodingAgent, session: URLSession)
	func fetch<Body, Success, Fail> (from api: APIEndPoint<Body, Success, Fail>,
									 onConfig: ((inout URLRequest) -> Void)?,
									 retryCount: Int,
									 retryPreJob:((()->Void)->Void)?,
									 then: @escaping (URLResult<Success, Fail, Error>) -> Void) -> URLSessionTask
		where Body: Queryed & Encoded, Success: Decodable, Fail: Decodable
}

open class BasedService<DecodingAgent: DecodeAgent, EncodingAgent: EncodeAgent>: FLikeAPIService {

	required public init(decoder: DecodingAgent, encoder: EncodingAgent, session: URLSession) {
		self.decoder = decoder
		self.encoder = encoder
		self.session = session
	}
	open var session: URLSession
	open var isDebug: Bool = false
	open var tempStr: String = ""
	open var decoder: DecodingAgent
	open var encoder: EncodingAgent
	open func fetch<Body, Success, Fail>(from api: APIEndPoint<Body, Success, Fail>,
										 onConfig: ((inout URLRequest) -> Void)? = nil,
										 retryCount: Int = 3,
										 retryPreJob: ((() -> Void) -> Void)? = nil,
										 then: @escaping (URLResult<Success, Fail, Error>) -> Void) -> URLSessionTask
		where Body: Encoded, Body: Queryed, Success: Decodable, Fail: Decodable {
			var request = api.request
			//                makeRequest(for: api)
			let isDebug = self.isDebug
			onConfig?(&request)
			print(request.url!.path, separator: "", terminator: " ")
			request.url!.parameters!.niceDump("query:")
			if let json = request.httpBody?.prettyPrintedJSONString {
				print("json:", json)
			}
			if let isFormdata = api.body as? IsFormData {
				isFormdata.formData.parameters.niceDump("formdata:")
			}
			let task = session.dataTask(with: request) { (data, reponse, error) in
				var result: URLResult<Success, Fail, Error>
				defer {
					DispatchQueue.main.async { then(result)}
				}
				if let error = error {
					return result = .failure(error)
				}

				guard let hr = reponse as? HTTPURLResponse else {
					return result = .failure(APIError.noResponse)

				}

				guard
					let data = data,
					let str = String(data: data, encoding: .utf8) else {
						return result = .decodeError(APIError.noData)
				}
				if str.isEmpty {
					guard retryCount > 0 else {result = .failure(APIError.retryNumberRunout);return}
					retryPreJob?({
						_ = self.fetch(from: api,
									   onConfig: onConfig,
									   retryCount: retryCount - 1,
									   retryPreJob: retryPreJob,
									   then: then)
					})
					return result = .retry(retryCount)
				}
				if let x = data.prettyPrintedJSONString {
					self.tempStr = "\(x)"
				} else {
					if isDebug {
						print(str)
					}
				}
				do {
					let model = try self.decoder.decode(Success.self, from: data)
					return result = .success(model)
				} catch let sError {
					if isDebug {
						dprint(sError)
						dprint(hr.url!)
						print("data: ")
						dprint(data.prettyPrintedJSONString ?? "No data")
					}
				}

				do {
					let apiFail = try self.decoder.decode(Fail.self, from: data)
					return result = .apiError(apiFail)
				} catch let decodeError {
					result = .decodeError(APIError.JSONDecodeError)
					if isDebug {
						dprint(decodeError)
					}
				}

			}
			DispatchQueue.global().async {
				task.resume()
			}
			return task
	}
	open func willstartRequest() {

	}
	open func didStartRequest() {

	}
	open func willHandleResponse() {

	}
	open func decodeSuccess<Success: Decodable>(data: Data, type: Success.Type) throws -> Success {
		try decoder.decode(type, from: data)
	}
	open func didgetSuccess<Success>(_ object: Success) {

	}

	open func decodeFailure<Fail: Decodable>(data: Data, type: Fail.Type) throws -> Fail {
		try decoder.decode(type, from: data)
	}
	open func didgetFailure<Fail>(_ object: Fail) {

	}
}

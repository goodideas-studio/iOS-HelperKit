//
//  FormData.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/10/31.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

public
protocol IsFormData {
	var formData: FormData {get}
}
public
struct FormData: Encoded {
    private static func makeRandom() -> UInt32 { UInt32.random(in: (.min)...(.max)) }
    public init(parameters: [String: String],
         encoding: String.Encoding = .utf8) {
        self.parameters = parameters
        self.encoding = encoding
        self.boundary  = String(format: "------------------------%08X%08X", Self.makeRandom(), Self.makeRandom())
    }
    public typealias Encoded = (data: Data, HeadFilld: [String: String])
    public var parameters: [String: String]
    public var encoding: String.Encoding = .utf8
    public var headerfield: [String: String] {
        guard
            let charset =
            CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(encoding.rawValue))
            else {return [:]}
        return ["Content-Type": "multipart/form-data; charset=\(charset); boundary=\(boundary)"]
    }
    public enum MultipartFormDataEncodingError: Error {
        case characterSetName
        case name(String)
        case value(String, name: String)
    }
    //    func makeRandom()->UInt32 { UInt32.random(in: (.min)...(.max)) }
    private let boundary: String

    public var encoded: Data? {

        var body = Data()

        for (rawName, rawValue) in parameters {
            if !body.isEmpty {
                body.append("\r\n".data(using: .utf8)!)
            }

            body.append("--\(boundary)\r\n".data(using: .utf8)!)

            guard
                rawName.canBeConverted(to: encoding),
                let disposition = "Content-Disposition: form-data; name=\"\(rawName)\"\r\n".data(using: encoding)
                else {return nil}
            body.append(disposition)

            body.append("\r\n".data(using: .utf8)!)

            guard let value = rawValue.data(using: encoding)
                else {return nil}

            body.append(value)
        }

        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        return body
    }

}

extension FormData: Queryed {
    public var queryDic: [String: String] {
        headerfield
    }
}

extension FormData: IsFormData {
	public var formData: FormData { self}
}

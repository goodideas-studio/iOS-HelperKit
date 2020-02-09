//
//  String+URLS.swift
//  GISHelperKit
//
//  Created by 游宗諭 on 2019/8/26.
//  Copyright © 2019 ytyubox. All rights reserved.
//

import Foundation

extension String {
    public var urls: [String] {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: utf16.count))
        var result = [String]()
        for match in matches {
            guard let range = Range(match.range, in: self) else { continue }
            let url = self[range]
            result.append(url.description)
        }
        return result
    }
	public var emptyNil: Self? {self.isEmpty ? nil : self }
}

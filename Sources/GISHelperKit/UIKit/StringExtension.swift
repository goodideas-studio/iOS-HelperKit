//
//  StringExtension.swift
//  GISHelperKit
//
//  Created by Jeremy Xue on 2019/8/30.
//  Copyright © 2019 jeremyxue. All rights reserved.
//

import Foundation
public
extension String {

    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

}

//
//  Storyboarded.swift
//  GISHelperKit
//
//  Created by Jeremy Xue on 2019/8/27.
//  Copyright © 2019 jeremyxue. All rights reserved.
//
#if canImport(UIKit)

import UIKit
public
protocol Storyboarded {
    static func instantiate(in storyboard: String) -> Self
}
public
extension Storyboarded where Self: UIViewController {
    static func instantiate(in storyboard: String) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}

#endif

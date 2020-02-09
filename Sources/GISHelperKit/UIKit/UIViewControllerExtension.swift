//
//  UIViewControllerExtension.swift
//  GISHelperKit
//
//  Created by Jeremy Xue on 2019/8/26.
//  Copyright © 2019 jeremyxue. All rights reserved.
//
#if canImport(UIKit)

import UIKit
public extension UIViewController {

    func presentStoryboardInitialViewController(in storyboard: String) {
        guard let vc = UIStoryboard(name: storyboard, bundle: nil).instantiateInitialViewController() else { return }
        self.present(vc, animated: true, completion: nil)
    }

}

#endif

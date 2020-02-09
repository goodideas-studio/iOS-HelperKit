//
//  UITextFieldExtension.swift
//  GISHelperKit
//
//  Created by Jeremy Xue on 2019/8/31.
//  Copyright © 2019 jeremyxue. All rights reserved.
//
 #if canImport(UIKit)

import UIKit
public
extension UITextField {

    var entered: Bool {
        guard let text = self.text else { return false }
        return !text.isEmpty ? true : false
    }
/*
    func setClearButton() {
        let clearButton = UIButton()
        clearButton.frame.size = CGSize(width: 48, height: 48)
        clearButton.setImage(UIImage(named: "clean"), for: .normal)
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        self.rightView = clearButton
        self.rightViewMode = .whileEditing
    }
    
    @objc private func clearText() {
        self.text = nil
    }
    
    @objc func setShowButton() {
        let showButton = UIButton()
        showButton.frame.size = CGSize(width: 48, height: 48)
        showButton.setImage(UIImage(named: "openeye"), for: .normal)
        showButton.addTarget(self, action: #selector(setHideButton), for: .touchUpInside)
        self.rightView = showButton
        self.rightViewMode = .whileEditing
        self.isSecureTextEntry = true
    }
    
    @objc func setHideButton() {
        let hideButton = UIButton()
        hideButton.frame.size = CGSize(width: 48, height: 48)
        hideButton.setImage(UIImage(named: "closeEye"), for: .normal)
        hideButton.addTarget(self, action: #selector(setShowButton), for: .touchUpInside)
        self.rightView = hideButton
        self.rightViewMode = .whileEditing
        self.isSecureTextEntry = false
    }
    
    func setVerificationCodeLabel(code: Int) {
        let backView = UIView()
        backView.frame.size = CGSize(width: 90, height: 28)
        let codeLabel = UILabel()
        codeLabel.frame = CGRect(x: 0, y: 0, width: 82, height: 28)
        codeLabel.backgroundColor = .black
        codeLabel.textColor = .white
        codeLabel.font = UIFont(name: PingFangSC.regular.rawValue, size: 17)
        codeLabel.text = "\(code)"
        codeLabel.textAlignment = .center
        backView.addSubview(codeLabel)
        self.rightView = backView
        self.rightViewMode = .always
    }
     */
}

#endif

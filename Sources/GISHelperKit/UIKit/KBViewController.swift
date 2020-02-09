//
//  KBViewController.swift
//  GISHelperKit
//
//  Created by Jeremy Xue on 2019/8/31.
//  Copyright © 2019 jeremyxue. All rights reserved.
//
#if canImport(UIKit)

import UIKit
open
class KBViewController: UIViewController {

    private var activeField: UITextField?
    private var textFields: [UITextField] = []
    private var keyboardScrollView: UIScrollView?

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerForKeyboardNotifications()
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resignKeyboardNotifications()
    }

    public func setupKeyboardManagement(textFields: [UITextField], in scrollView: UIScrollView) {
        self.textFields = textFields
        self.textFields.forEach({$0.delegate = self; $0.returnKeyType = .next})
        self.textFields.last?.returnKeyType = .done
        self.keyboardScrollView = scrollView
        self.keyboardScrollView?.keyboardDismissMode = .interactive
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        self.keyboardScrollView?.addGestureRecognizer(tap)
    }

    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] (aNoti) in
            guard let self = self else { return }
            self.keyboardWasShown(aNoti)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] (aNoti) in
            guard let self = self else { return }
            self.keyboardWillBeHidden(aNoti)
        }
    }

    private func resignKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func keyboardWasShown(_ aNotification: Notification?) {
        let info = aNotification?.userInfo
        let kbSize = (info?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
        if let scrollView = keyboardScrollView {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            scrollView.scrollRectToVisible(activeField?.frame ?? .zero, animated: true)
        }
    }

    private func keyboardWillBeHidden(_ aNotification: Notification?) {
        let contentInsets: UIEdgeInsets = .zero
        if let scrollView = keyboardScrollView {
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }

}

// MARK: - UITextFieldDelegate
extension KBViewController: UITextFieldDelegate {

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let index = textFields.firstIndex(where: {$0 == textField }) else { return true }
        let nextIndex = index + 1
        if nextIndex < textFields.count {
            textFields[nextIndex].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

}

#endif

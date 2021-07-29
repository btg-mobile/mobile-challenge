//
//  UIViewController+HideKeyboard.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import UIKit

extension UIViewController {
    func hideKeyboardOnTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc fileprivate func hideKeyboard() {
        view.endEditing(true)
    }
}

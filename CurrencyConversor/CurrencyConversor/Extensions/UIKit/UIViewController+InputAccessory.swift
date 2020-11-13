//
//  UIViewController+InputAccessory.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 12/11/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addInputAccessoryForTextFields(textFields: [UITextField],
                                        dismissable: Bool = true,
                                        previousNextable: Bool = false) {
        for (index, textField) in textFields.enumerated() {
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            
            var items = [UIBarButtonItem]()
            if previousNextable {
                let previousButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem(rawValue: 103)!,
                                                          target: nil,
                                                          action: nil)
                previousButton.width = 30
                previousButton.tintColor = .black
                if textField == textFields.first {
                    previousButton.isEnabled = false
                } else {
                    previousButton.target = textFields[index - 1]
                    previousButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                let nextButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem(rawValue: 104)!,
                                                      target: nil,
                                                      action: nil)
                nextButton.width = 30
                nextButton.tintColor = .black
                if textField == textFields.last {
                    nextButton.isEnabled = false
                } else {
                    nextButton.target = textFields[index + 1]
                    nextButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                items.append(contentsOf: [previousButton, nextButton])
            }
            
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                         target: nil,
                                         action: nil)
            let doneButton = UIBarButtonItem.init(title: StringIdentifier.ok.getString(),
                                                  style: .done,
                                                  target: view,
                                                  action: #selector(UIView.endEditing))
            items.append(contentsOf: [spacer, doneButton])
            
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
    }
}

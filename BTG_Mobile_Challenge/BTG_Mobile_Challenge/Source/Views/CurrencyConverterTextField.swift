//
//  CurrencyConverterTextField.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import UIKit

final class CurrencyConverterTextField: UITextField {
    
    override var bounds: CGRect {
        didSet {
            setCornerRadius()
        }
    }
    
    init(placeholder: String, frame: CGRect) {
        super.init(frame: frame)
        self.placeholder = placeholder
        self.backgroundColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 0.1510314941)
        self.tintColor = .black
    }
    
    required convenience init?(coder: NSCoder) {
        guard let frame = coder.decodeObject(forKey: "frame") as? CGRect,
              let placeholder = coder.decodeObject(forKey: "placeholder") as? String else {
            return nil
        }
        self.init(placeholder: placeholder, frame: frame)
    }
    
    private func setCornerRadius() {
        self.layer.cornerRadius = self.frame.height * 0.2
    }
    
    private func setTextField() {
        keyboardType = .numberPad
        textAlignment = .center
        borderStyle = .roundedRect
    }
    
}

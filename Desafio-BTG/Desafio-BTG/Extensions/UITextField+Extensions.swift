//
//  UITextField+Extensions.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 31/03/21.
//

import UIKit

// MARK: - Extensions

extension UITextField {
    
    func setLeftPaddingPoints( _ space: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    public convenience init(_ placeholderText: String) {
        self.init()
        self.borderStyle = .none
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(red: 254/255, green: 62/255, blue: 109/255, alpha: 0.2)
        self.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.font = UIFont.systemFont(ofSize: 17)
        self.autocorrectionType = .no
        // placeholder
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)]))
        self.attributedPlaceholder = placeholder
        self.setLeftPaddingPoints(10)
    }
}

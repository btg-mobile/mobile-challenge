//
//  ChangeCurrencyButton.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import UIKit

final class ChangeCurrencyButton: UIButton {
    
    override var bounds: CGRect {
        didSet {
            setCornerRadius()
        }
    }
    
    init(frame: CGRect, selector: Selector) {
        super.init(frame: frame)
        self.addTarget(self, action: selector, for: .touchUpInside)
        self.backgroundColor = #colorLiteral(red: 0.2941176471, green: 0.4156862745, blue: 0.8352941176, alpha: 1)
        self.tintColor = .white
    }
    
    required convenience init?(coder: NSCoder) {
        guard let frame = coder.decodeObject(forKey: "frame") as? CGRect,
              let selector = coder.decodeObject(forKey: "selector") as? Selector else {
            return nil
        }
        self.init(frame: frame, selector: selector)
    }
    
    private func setButton() {
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        clipsToBounds = true
    }
    
    private func setCornerRadius() {
        self.layer.cornerRadius = self.frame.height * 0.2
    }
}

//
//  CurrencyLabel.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import UIKit

final class CurrencyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let frame = coder.decodeObject(forKey: "frame") as? CGRect else {
            return nil
        }
        self.init(frame: frame)
    }
    
    private func setTextField() {
        textAlignment = .center
        textColor = #colorLiteral(red: 0.2941176471, green: 0.4156862745, blue: 0.8352941176, alpha: 1)
        font = UIFont.preferredFont(forTextStyle: .largeTitle)
        adjustsFontSizeToFitWidth = true
        backgroundColor = .white
    }
}

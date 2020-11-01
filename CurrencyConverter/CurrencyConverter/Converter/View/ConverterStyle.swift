//
//  ConverterStyle.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import UIKit

extension Style {
    enum Home {
        static let currencyHeight: CGFloat = 50
        static let inputTextPadding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        static let widthOffset: CGFloat = -36
        
        enum Conversor {
            static let titleHeight: CGFloat = 20
            static let valueFieldHeight: CGFloat = 26
            static let inputPlaceholder: String = "Value"
            static let separatorHeight: CGFloat = 1
        }
    }
}

//
//  DesignSystem.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 22/03/21.
//

import UIKit

class DesignSystem {
    
    /// Padding from the LayoutMarguinsGuide to the UI elements
    static let marginsPadding: CGFloat = 40
    
    static func getButtonWidth(view: UIView) -> CGFloat {
        return view.frame.width/5
    }
}

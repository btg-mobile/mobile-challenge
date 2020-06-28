//
//  UIView.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import UIKit

extension UIView {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    func round() {
        cornerRadius = frame.size.width / 2
        layer.masksToBounds = cornerRadius > 0
    }
}

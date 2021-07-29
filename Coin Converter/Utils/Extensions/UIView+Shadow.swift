//
//  UIView+Shadow.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import UIKit

extension UIView {
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.16
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 10
        layer.cornerRadius = 16
        layer.shouldRasterize = true
    }
}

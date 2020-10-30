//
//  UIView+Factory.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import UIKit

extension UIView {
    func cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        clipsToBounds = true
        return self
    }
    
    func useConstraint() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

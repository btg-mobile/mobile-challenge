//
//  UIView+Extension.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 18/12/20.
//

import UIKit

extension UIView {
    
    func addAnchor(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, padding: UIEdgeInsets = .zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        bottom.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        
    }
    
    func addContraintsRelative(to View: UIView, with Multiplier: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalTo: View.widthAnchor, multiplier: Multiplier).isActive = true
        heightAnchor.constraint(equalTo: View.heightAnchor, multiplier: Multiplier).isActive = true
    }
}

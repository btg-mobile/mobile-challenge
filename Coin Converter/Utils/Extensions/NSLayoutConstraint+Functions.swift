//
//  NSLayoutConstraint+Functions.swift
//  Coin Converter
//
//  Created by Igor Custodio on 27/07/21.
//

import UIKit

extension NSLayoutConstraint {
    
    typealias ConstraintSides = (top: CGFloat, right: CGFloat, bottom: CGFloat, left: CGFloat)
    
    static func setSize(item: Any, width: CGFloat, height: CGFloat) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(item: item, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height),
            NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        ]
    }
    
    static func setProperty(item: Any, value: CGFloat, attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: item, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: value)
    }
    
    static func setConstraintEqualParent(item: Any, parent: Any, margin: ConstraintSides) -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: parent, attribute: .top, multiplier: 1, constant: margin.top)
        let rightConstraint = NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: parent, attribute: .right, multiplier: 1, constant: margin.right)
        let bottomConstraint = NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: parent, attribute: .bottom, multiplier: 1, constant: margin.bottom)
        let leftConstraint = NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: parent, attribute: .left, multiplier: 1, constant: margin.left)
        
        return [topConstraint, rightConstraint, bottomConstraint, leftConstraint]
    }
}

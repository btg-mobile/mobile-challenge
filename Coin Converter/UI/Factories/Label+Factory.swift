//
//  Label+Factory.swift
//  Coin Converter
//
//  Created by Igor Custodio on 27/07/21.
//

import UIKit

struct UILabelProperties {
    var alignment: NSTextAlignment? = nil
    var color: UIColor? = nil
    var size: CGFloat? = nil
}

extension UILabel {
    static func createLabel(text: String, properties: UILabelProperties? = nil) -> UILabel {
        let label = UILabel()
        label.text = text
        
        if let props = properties {
            if let alignment = props.alignment {
                label.textAlignment = alignment
            }
            
            if let color = props.color {
                label.textColor = color
            }
            
            if let size = props.size {
                label.font = label.font.withSize(size)
            }
        }
        
        return label
    }
}

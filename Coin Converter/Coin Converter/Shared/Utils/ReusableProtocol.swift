//
//  ReusableProtocol.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import UIKit

protocol ReusableProtocol {
    
}

extension ReusableProtocol {
    
    /// Returns the UINib with the name of the class.
    static var nib: UINib {
        let name = String(describing: Self.self)
        guard let reference = self as? AnyClass else {
            fatalError("Error getting the class implementing Reusable protocol.")
        }
        
        let bundle = Bundle(for: reference)
        return UINib(nibName: name, bundle: bundle)
    }
    
    /// Returns the identifier based on the name of the class.
    static var identifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReusableProtocol {
    
}

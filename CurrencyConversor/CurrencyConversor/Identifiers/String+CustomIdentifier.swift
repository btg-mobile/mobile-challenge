//
//  String+CustomIdentifier.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 06/11/20.
//

import Foundation

extension String  {
    
    public init(withCustomIdentifier identifier: CustomIdentifier) {
        self.init(NSLocalizedString(identifier.key, comment: ""))
    }
    
    public init(withCustomIdentifier identifier: CustomIdentifier, comment: String) {
        self.init(NSLocalizedString(identifier.key, comment: comment))
    }
    
}

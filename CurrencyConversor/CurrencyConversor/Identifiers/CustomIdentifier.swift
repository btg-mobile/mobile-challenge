//
//  CustomIdentifier.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 06/11/20.
//

import Foundation

public protocol CustomIdentifier {
    var key: String { get }
}

extension CustomIdentifier where Self: RawRepresentable, Self.RawValue == String {
    
    public var key: String { return self.rawValue }
    
}


//
//  ServiceDns.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 09/11/20.
//

import Foundation

protocol ServiceDns {
    
    var dns: String { get }
    
}

extension ServiceDns where Self: RawRepresentable, Self.RawValue == String {
    
    var dns: String {
        return rawValue
    }
}

//
//  CommonData.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation

final class CommonData {
    private init() {}
    static let shared = CommonData()
    
    @UserDefaultAccess(key: "fromCurrency", defaultValue: "USD")
    public var fromCurrencyStorage: String
    
    @UserDefaultAccess(key: "toCurrency", defaultValue: "USD")
    public var toCurrencyStorage: String
    
    @UserDefaultAccess(key: "selectedTypeCurrency", defaultValue: "none")
    public var selectedTypeCurrency: String
    
    @UserDefaultAccess(key: "favorites", defaultValue: [])
    public var favorites: [String]
}

//
//  CurrenciesListRequestURL.swift
//  iOS Giovane Barreira
//
//  Created by Giovane Barreira on 10/4/20.
//

import Foundation

struct CurrenciesListRequestURL {
    
    /// MARK: - Properties
   private let baseUrl = "http://api.currencylayer.com/"
   private let apiMethod = "list?"
   private let accessKey = "access_key=8835cd634cf73c557729b51af3c57bea"
    var endpoint: String {
        return "\(baseUrl)\(apiMethod)\(accessKey)"
    }
       
}


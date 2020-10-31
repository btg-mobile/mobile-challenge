//
//  CurrencyProvider.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation

enum CurrencyProvider {
    case list
    case live
}

extension CurrencyProvider: ServiceProtocol {
    var path: String {
        switch self {
        
        case .list:
            return "\(BaseParameterCurrency.shared.basePath)/list"
        case .live:
            return "\(BaseParameterCurrency.shared.basePath)/live"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        
        case .list:
            return [
                "access_key": BaseParameterCurrency.shared.apiKey
            ]
        case .live:
            return [
                "access_key": BaseParameterCurrency.shared.apiKey
            ]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}

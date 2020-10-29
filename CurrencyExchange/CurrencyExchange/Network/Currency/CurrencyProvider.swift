//
//  CurrencyProvider.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation

enum CurrencyProvider {
    case list
}

extension CurrencyProvider: ServiceProtocol {
    var path: String {
        switch self {
        
        case .list:
            return "\(BaseParameterCurrency.shared.basePath)/list"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        
        case .list:
            return [
                "access_key": BaseParameterCurrency.shared.apiKey
            ]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}

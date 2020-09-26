//
//  ConverterService.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

enum ConverterService {
    case currencyList
    case liveConverter
}

extension ConverterService: ServiceProtocol {
    private var url: String { "http://api.currencylayer.com/" }
    private var apiKey: String { "access_key=98d190b4ad2ecb4e667cdb821797d622" }
    
    var path: String {
        switch self {
        case .currencyList:
            return "\(url)list?\(apiKey)"
        case .liveConverter:
            return "\(url)live?\(apiKey)"
        }
    }
    
    var method: HttpMethod {
        .get
    }
    
    var parameters: [String : String]? {
        nil
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}

//
//  CurrencyRouter.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
enum CurrencyRouter {
    case live(String, String)
    case list
}

extension CurrencyRouter: HTTPRouter {
    var baseUrl: URL? {
        return URL(string: Constants.Network.baseUrl)
    }
    
    var path: String {
        switch self {
        case .live:
            return "/live"
        case .list:
            return "/list"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String: String] {
        switch self {
        case let .live(currencies, source):
            return ["currencies": currencies,"source": source,"format": "1"]
        case .list:
            return [:]
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

//
//  CurrencyService.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 16/12/20.
//

import Foundation

enum CurrencyService: ServiceProtocol {
    case list
    case live
    
    var baseURL: URL {
        return Endpoint.baseURL()
    }
    
    var path: String {
        switch self {
        case .list:
            return "list"
        case .live:
            return "live"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case .list:
            return .requestParameters(["access_key": Endpoint.apiKey()])
        case .live:
            return .requestParameters(["access_key": Endpoint.apiKey()])
        }
    }
    
    var headers: Headers? {
        return [:]
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}

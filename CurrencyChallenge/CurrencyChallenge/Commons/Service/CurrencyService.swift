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
            return .requestParameters([:])
        case .live:
            return .requestParameters([:])
        }
    }
    
    var headers: Headers? {
        return ["access_key": Endpoint.apiKey()]
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}

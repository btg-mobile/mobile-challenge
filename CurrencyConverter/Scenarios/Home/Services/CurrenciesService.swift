//
//  CurrenciesService.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import Moya

enum CurrenciesService {
    case getCurrencies
    case getQuotes
}

extension CurrenciesService: TargetType {    
    var baseURL: URL {
        return URL(string: Service.apiURL)!
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var path: String {
        switch self {
        case .getCurrencies:
            return "list"
        case .getQuotes:
            return "live"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        let params = [
            "access_key": Service.apiKey
        ]
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }

    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
}

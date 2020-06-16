//
//  ConvertCurrencyRouter.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 15/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Moya

enum ConvertCurrencyRouter {
    case live(String, String)
}

extension ConvertCurrencyRouter: TargetType {
    var path: String {
        switch self {
        case .live:
            return Paths.live.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .live:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .live(currencies, source):
            var parameters: [String: Any] = [:]
            parameters[Keys.accessKey.rawValue] = Values.ApiKey.rawValue
//            parameters[Keys.currencies.rawValue] = currencies
//            parameters[Keys.source.rawValue] = source
//            parameters[Keys.format.rawValue] = 1
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    
}

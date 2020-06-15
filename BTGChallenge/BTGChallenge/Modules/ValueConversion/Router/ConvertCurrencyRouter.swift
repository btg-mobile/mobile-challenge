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
    case live
}

extension ConvertCurrencyRouter: TargetType {
    var path: String {
        return Paths.live.rawValue
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        var parameters: [String: Any] = [:]
        parameters[Keys.accessKey.rawValue] = Values.ApiKey.rawValue
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    
}

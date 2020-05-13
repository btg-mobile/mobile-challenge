//
//  Router.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 12/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

enum Router {
    case convert(String, String, String)
}

extension Router: HTTPRouter {
    var baseUrl: URL {
        return URL(string: Constants.Networking.baseUrl)! // swiftlint:disable:this force_unwrapping
    }
    
    var path: String {
        switch self {
        case let .convert(fromCoin, toCoin, amount):
            return "/convert?" +
                        "access_key=\(Constants.Networking.accessKey)" +
                        "&from=\(fromCoin)" +
                        "&to=\(toCoin)" +
                        "&amount=\(amount)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        return nil
    }
}

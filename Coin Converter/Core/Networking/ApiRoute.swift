//
//  ApiRoute.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import Foundation

enum ApiRoute {
    case list
    case live

    var path: String {
        switch self {
            case .list:
                return "list"
            case .live:
                return "live"
        }
    }
    
    func getUrl(apiBase: String) throws -> URL {
        guard let url = URL(string: "\(apiBase)\(self.path)") else {
            throw ErrorType.parseUrlFail
        }
        return url
    }
}

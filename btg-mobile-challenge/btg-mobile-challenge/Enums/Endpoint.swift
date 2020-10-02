//
//  Endpoint.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import Foundation

/// Endpoints available.
enum Endpoint: String {
    // - MARK: Cases
    /// Endpoint for live rates.
    case live = "live?"
    /// Endpoint for supported currencies.
    case currencies = "list?"
}

// - MARK: Extension
extension Endpoint {
    /// The private API key.
    /// It should **never** be pushed to remote.
    private var accessKey: String {
        return "access_key="
    }

    /// The base API URL.
    private var base: String {
        return "http://api.currencylayer.com/"
    }

    //- MARK: URL
    /// Computed variable responsible for building eache endpoint's URL.
    var url: URL? {
        switch self {
        case .live:
            guard let url = URL(string: "\(base)\(Endpoint.live.rawValue)\(accessKey)") else {
                return nil
            }
            return url
        case .currencies:
            guard let url = URL(string: "\(base)\(Endpoint.currencies.rawValue)\(accessKey)") else {
                return nil
            }
            return url
        }
    }
}

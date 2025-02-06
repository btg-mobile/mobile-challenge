//
//  Endpoint.swift
//  mobileChallenge
//
//  Created by Henrique on 03/02/25.
//

import Foundation

enum Endpoint{
    case fetchCurrency(url: String = "/Banking-iOS/mock-interview/main/api/list.json")
    case fetchCurrencyConversion(url: String = "/Banking-iOS/mock-interview/main/api/live.json")
    
    var request: URLRequest? {
        guard let url = self.url else { return nil}
        let request = URLRequest(url: url)
        
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        return components.url
    }
    
    private var queryItems: [URLQueryItem]{
        switch self {
        case .fetchCurrency( _):
            return [
            ]
        case .fetchCurrencyConversion(_):
        return [
            ]
        }
    }
    
    private var path: String{
        switch self {
        case .fetchCurrency(let url):
            return url
        case .fetchCurrencyConversion(let url):
            return url
        }
    }
    private var httpMethod: String {
        switch self {
        case .fetchCurrency:
            return HTTP.Method.get.rawValue
        case .fetchCurrencyConversion:
            return HTTP.Method.get.rawValue
        }
    }
    
}

//https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/list.json
//https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/live.json

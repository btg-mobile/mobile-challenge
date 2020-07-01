//
//  CurrencyRouter.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 30/06/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

public typealias Parameters = [String: String]

protocol RequestProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var accessKey: [String: String] { get }
    var method: HTTPMethod {get}
    func asURLRequest() throws -> URLRequest
    
}
enum CurrencyRouter: RequestProtocol {
    case list
    case live
    case convert(parameters: Parameters)
    
    var accessKey: [String: String] {
        return ["access_key": "f2954fa6f49f6af0b3fe2c631cc821a2"]
    }
    
    func asURLRequest() throws -> URLRequest {
        
        guard var urlComp = URLComponents(string: baseUrl) else {
            fatalError("URLComponents invalid")
        }
        
        var baseParameters: Parameters = accessKey
        switch self {
            
        case .convert(let parameters):
            baseParameters = parameters
            
        default:break
        }
        urlComp.queryItems = baseParameters.map({ URLQueryItem(name: $0.key, value: $0.value)})
        
        guard let url = urlComp.url else {
            fatalError("url invalid")
        }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
    
    var baseUrl: String {
        return "http://api.currencylayer.com"
    }
    
    var path: String {
        switch self {
        case .list:
            return "/list"
        case .live:
            return  "/live"
        case .convert:
            return  "/convert"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}

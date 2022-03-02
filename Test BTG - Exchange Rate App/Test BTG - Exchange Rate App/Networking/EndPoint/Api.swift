//
//  Api.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 01/03/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

// MARK: - Enum

enum Api {
    case live
    case list
}

extension Api: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: NetworkManager.shared.environmentBaseURL) else {
            do { fatalError("baseURL could not be configured.")}
        }
        return url
    }
    
    var path: String {
        switch self {
        case .live:
            return "/list"
        case .list:
            return "/live"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .live:
            return .get
        case .list:
            return .get
        }
    }
    
    var task: HTTPTask {
        return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, addtionHeaders: headers)
    }
    
    var headers: HTTPHeaders? {
        return ["Accept" : NetworkHeaderEnconding.JSON.rawValue]
    }
    
}

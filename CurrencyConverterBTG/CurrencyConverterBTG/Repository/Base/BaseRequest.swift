//
//  BaseRequest.swift
//
//  Created by Silvia Florido on 01/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

public protocol BaseRequest {
    
    var rawUrl: String {get}
    var method: HTTPMethod {get}
    var body: [String : Any]? {get}
    var headers: [String : String]? {get}
}

public extension BaseRequest {
    
    func asURLRequest() -> URLRequest {
        let raw = self.rawUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: raw)!
        var request = URLRequest(url: url)
        
        request.timeoutInterval = 60.0
        request.cachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
        request.httpMethod = self.method.toString()
        
        if let headers = self.headers {
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
  
        if(self.method != HTTPMethod.get){
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            if let body = self.body {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        
        return request
    }
}



public enum HTTPMethod: Int {
    case get
    case post
    case put
    case patch
    case delete
    
    public func toString() -> String {
        switch self {
        case .get:     return "GET"
        case .post:    return "POST"
        case .put:     return "PUT"
        case .patch:   return "PATCH"
        case .delete:  return "DELETE"
        }
    }
}

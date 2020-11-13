//
//  APIManager.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 09/11/20.
//

import Foundation

private enum Constants {
    static let contentType     = "Content-Type"
    static let applicationJson = "application/json"
    static let timeoutInterval = 60.0
    
}

enum HttpMethod: String {
    case post = "POST"
    case get  = "GET"
}

class APIManager: NSObject {
    
    static let sharedInstance: APIManager = APIManager()
    
    private override init() { }
    
    public func requestApi(httpMethod: String = HttpMethod.get.rawValue,
                           apiUrl: String,
                           params: String?,
                           handler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        
        if let url = URL.with(string: apiUrl, param: params) {
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = httpMethod
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let HTTPHeaderField_ContentType  = Constants.contentType
            let ContentType_ApplicationJson  = Constants.applicationJson
            urlRequest.timeoutInterval = Constants.timeoutInterval
            urlRequest.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
            urlRequest.addValue(ContentType_ApplicationJson, forHTTPHeaderField: HTTPHeaderField_ContentType)
            
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                handler(data, response, error)
            }
            dataTask.resume()
        }
    }
}

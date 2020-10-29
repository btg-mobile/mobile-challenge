//
//  File.swift
//  CurrencyServices
//
//  Created by Breno Aquino on 29/10/20.
//

import Foundation

public class Network {
    
    public enum Scheme: String {
        case http = "http"
        case https = "https"
    }
    
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    static func createUrl(scheme: Scheme, baseUrl: String, path: String, params: [String: String]?) -> URL? {
        var url = URLComponents()
        url.scheme = scheme.rawValue
        url.host = baseUrl
        url.path = path
        url.queryItems = params?.map { URLQueryItem(name: $0.key, value: $0.value) }
        return url.url
    }
    
    static func createRequest(scheme: Scheme, method: Method, baseUrl: String, path: String, params: [String: String]?) -> URLRequest? {
        guard let url = Network.createUrl(scheme: scheme, baseUrl: baseUrl, path: path, params: params) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
    public static func request(scheme: Scheme = .http, method: Method, baseUrl: String, path: String, params: [String: String]? = nil, callback: @escaping (Result<Dictionary<String, Any>, NSError>) -> Void) {
        guard let request = Network.createRequest(scheme: scheme, method: method, baseUrl: baseUrl, path: path, params: params) else { return }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                callback(.failure(error as NSError))
                return
            }
            
            if let data = data, let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode {
                do {
                    let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let dict = dict {
                        callback(.success(dict))
                    } else {
                        callback(.failure(NSError()))
                    }
                } catch let error {
                    callback(.failure(error as NSError))
                }
            } else {
                callback(.failure(NSError()))
            }
        }
        task.resume()
    }
}

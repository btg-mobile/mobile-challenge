//
//  APICurrency.swift
//  mobile-challenge
//
//  Created by Marcos Fellipe Costa Silva on 24/04/21.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}
public typealias Completion<T: Decodable> = (Result<T, Error>) -> Void
public typealias Parameters = [String: Any]

fileprivate let apiKey = ""
fileprivate let baseURL = "http://api.currencylayer.com"



public class APICurrency {
    
    enum Paths: String {
        case list = "/list"
        case live = "/live"
    }
    
    
    public static func getLive(completion: @escaping Completion<CurrencyValueModel>) {
        
        GenericRequest.request(url: Paths.live.rawValue, method: .GET, completion: completion)
    }
     
    public static func getList(completion: @escaping Completion<CurrencyNameModel>) {
        GenericRequest.request(url: Paths.list.rawValue, method: .GET, completion: completion)
    }
    
}

public class GenericRequest {
    
    static func request<T:Decodable>(url: String, method: HTTPMethod, urlParameters: Parameters? = nil, body parameters: Parameters? = nil, completion: @escaping Completion<T>){
        let session = URLSession.shared
        var serviceUrl = URLComponents(string: baseURL + url + apiKey )
        
        var urlQueryItemns: [URLQueryItem] = [URLQueryItem(name: "access_key", value: "07ef133e3c66f5ecd8771dce848065b4")]
        
        urlParameters?.forEach {
            urlQueryItemns.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        serviceUrl?.queryItems = urlQueryItemns
        guard let componentURL = serviceUrl?.url else { return }
        var request = URLRequest(url: componentURL)
        request.httpMethod = method.rawValue
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        if let parameterDictionary = parameters  {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            request.httpBody = httpBody
        }
        
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(responseModel))
                } catch {
                    completion(.failure(error))
                }
                
            }
        }.resume()
    }
    
}

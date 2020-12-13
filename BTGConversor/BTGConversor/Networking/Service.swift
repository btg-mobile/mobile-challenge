//
//  Service.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/13/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import Foundation

class Service<T: Target> {
    
    var executor: AppExecutor
    var urlSession: URLSession
    
    init() {
        self.urlSession = .init(configuration: URLSessionConfiguration.default)
        self.executor = .init()
    }
    
    @discardableResult
    public func fetch<V: Codable>(_ target: T,
                                  dataType: V.Type,
                                  completion: @escaping (Result<V, BTGError>, URLResponse?) -> Void) -> URLSessionDataTask {
        
        let request = composeRequest(target)
        
        let dataTask = self.executor.execute(request: request, session: urlSession) { (data, response, error) in
            if let _ = error {
                completion(.failure(BTGError.unkown), response)
            }
            
            do {
                if let object  = try self.parseData(data, type: dataType) {
                    completion(.success(object), response)
                    return
                }
                completion(.failure(BTGError.generic("Please try again")), response)
                return
            } catch {
                completion(.failure(BTGError.parse), response)
                return
            }
        }
        
        return dataTask
        
    }
    
    func composeRequest<T: Target>(_ target: T) -> URLRequest {
        var request = URLRequest(url: URL(with: target))
        request.allHTTPHeaderFields = target.headers
        request.httpMethod = target.method.rawValue
        
        /* Even though I have no more option, if I get a different kind of taks, it comes over here.
         * The default isn't there, it should fail fast and loud
        */
        switch target.task {
        case .requestPlain:
            return request
        }
        
    }
    
    private func parseData<V: Codable>(_ data: Data?, type: V.Type) throws -> V? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        let object = try decoder.decode(type.self, from: data)
        return object
        
    }
    
}

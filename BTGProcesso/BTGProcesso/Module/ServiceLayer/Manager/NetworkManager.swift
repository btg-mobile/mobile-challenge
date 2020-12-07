//
//  ServiceLayer.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 07/12/20.
//

import Foundation


public class NetworkManager {

    private lazy var session = {
        URLSession.shared
    }()
    
    public func request(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }).resume()
    }
    
}

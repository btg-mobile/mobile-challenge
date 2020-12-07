//
//  QuotaAPI.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 07/12/20.
//

import Foundation

struct Quota: Decodable {
    
}

class QuotaAPI {
    
    let manager: NetworkManager = {
        NetworkManager()
    }()
    
    func request(url: URL, completion: @escaping (Result<Quota, Error>) -> Void) {
        manager.request(url: url) { result in
            switch result {
            
            case .success(_):
                do {
                    let qouta = try self.decode(data: result.get())
                    completion(.success(qouta))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}

extension QuotaAPI: NetworkRequestProtocol {
    
    func decode(data: Data) throws -> Quota {
        do {
            return try jsonDecode.decode(Quota.self, from: data)
        } catch let error {
            throw error
        }
    }
}

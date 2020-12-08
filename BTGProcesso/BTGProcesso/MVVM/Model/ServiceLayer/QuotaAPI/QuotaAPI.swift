//
//  QuotaAPI.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 07/12/20.
//

import Foundation


public class QuotaAPI {
    
    private let manager: NetworkManager = {
        NetworkManager()
    }()
    
    func request<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
        manager.request(url: url) { (result: Result<T, Error>) in
            switch result {
            
            case .success(_):
                completion(try? result.get())
            case .failure(_):
                completion(nil)
            }
        }
    }
}

//
//  ProviderProtocol.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 16/12/20.
//

import Foundation

protocol ProviderProtocol {
    func request<T>(type: T.Type, service: ServiceProtocol,
                    completion: @escaping (NetworkResponse<T>) -> Void) where T: Decodable
}

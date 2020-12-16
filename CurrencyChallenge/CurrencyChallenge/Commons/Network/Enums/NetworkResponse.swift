//
//  NetworkResponse.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 16/12/20.
//

import Foundation

enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}

//
//  CurrencyListServiceProtocol.swift
//  BTG mobile challange
//
//  Created by Uriel Barbosa Pinheiro on 03/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case genericError
    case apiError(errorDescription: String?)
}

typealias CurrencyListServiceCallback = (Result<CurrencyListModel, Error>) -> Void

protocol CurrencyListServiceProtocol {
    func fetchCurrencyList(completion: @escaping CurrencyListServiceCallback)
}

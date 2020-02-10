//
//  DataManager.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 09/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation

protocol DataManager {
    func request<T>(_ request:CurrencyConverterRequests, completion: @escaping (T?,Error?) -> ())
}

enum CurrencyConverterRequests {
    case getExchangeRates
    case getSupportedCurrencies
}

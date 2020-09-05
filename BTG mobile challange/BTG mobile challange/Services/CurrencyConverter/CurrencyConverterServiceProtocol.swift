//
//  CurrencyConverterServiceProtocol.swift
//  BTG mobile challange
//
//  Created by Uriel Barbosa Pinheiro on 04/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

typealias CurrencyConverterServiceCallback = (Result<CurrencyConverterModel, Error>) -> Void

protocol CurrencyConverterServiceProtocol {
    func fetchCurrencyQuotes(completion: @escaping CurrencyConverterServiceCallback)
}

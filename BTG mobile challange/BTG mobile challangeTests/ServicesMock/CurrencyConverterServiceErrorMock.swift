//
//  CurrencyConverterServiceErrorMock.swift
//  BTG mobile challangeTests
//
//  Created by Uriel Barbosa Pinheiro on 05/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

@testable import BTG_mobile_challange
import Foundation

class CurrencyConverterServiceErrorMock: CurrencyConverterServiceProtocol {
    func fetchCurrencyQuotes(completion: @escaping CurrencyConverterServiceCallback) {
        completion(.failure(ApiError.genericError))
    }
}

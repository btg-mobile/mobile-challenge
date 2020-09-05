//
//  CurrencyListServiceErrorMock.swift
//  BTG mobile challangeTests
//
//  Created by Uriel Barbosa Pinheiro on 05/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

@testable import BTG_mobile_challange
import Foundation

class CurrencyListServiceErrorMock: CurrencyListServiceProtocol {
    func fetchCurrencyList(completion: @escaping CurrencyListServiceCallback) {
        completion(.failure(ApiError.genericError))
    }
}

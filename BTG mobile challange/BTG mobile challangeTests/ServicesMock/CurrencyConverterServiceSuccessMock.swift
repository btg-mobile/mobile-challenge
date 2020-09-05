//
//  CurrencyConverterServiceSuccessMock.swift
//  BTG mobile challangeTests
//
//  Created by Uriel Barbosa Pinheiro on 05/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

@testable import BTG_mobile_challange
import Foundation

class CurrencyConverterServiceSuccessMock: CurrencyConverterServiceProtocol {
    func fetchCurrencyQuotes(completion: @escaping CurrencyConverterServiceCallback) {
        let model = CurrencyConverterModel(success: true, source: "USD", quotes: [
            "USDAED": 3.672901,
            "USDAFN": 76.849607,
        ], error: nil)
        completion(.success(model))
    }
}

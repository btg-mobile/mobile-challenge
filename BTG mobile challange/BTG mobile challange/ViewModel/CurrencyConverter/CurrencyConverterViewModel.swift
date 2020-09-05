//
//  CurrencyConverterViewModel.swift
//  BTG mobile challange
//
//  Created by Uriel Barbosa Pinheiro on 03/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

public class CurrencyConverterViewModel {

    @Published var convertedValue: Double?

    private let servicesProvider: CurrencyConverterServiceProtocol

    private var quotes: [String: Double]?

    init(servicesProvider: CurrencyConverterServiceProtocol) {
        self.servicesProvider = servicesProvider
        servicesProvider.fetchCurrencyQuotes { response in
            switch response {
            case .failure(let error):
                #if DEBUG
                print(error)
                #endif
            case .success(let data):
                self.quotes = data.quotes
            }
        }
    }

    func convert(from origin: String, to destiny: String, value: Double) {
        guard let originRate = quotes?["USD\(origin)"],
            let destinyRate = quotes?["USD\(destiny)"] else { return }
        let invertedOriginRate = 1 / originRate

        self.convertedValue = value * invertedOriginRate * destinyRate
    }
}

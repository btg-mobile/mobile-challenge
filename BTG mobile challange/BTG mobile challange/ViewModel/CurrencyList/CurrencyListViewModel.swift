//
//  CurrencyListViewModel.swift
//  BTG mobile challange
//
//  Created by Uriel Barbosa Pinheiro on 03/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

public class CurrencyListViewModel {

    @Published var currencyList: [Dictionary<String, String>.Element]?

    private let servicesProvider: CurrencyListServiceProtocol

    init(servicesProvider: CurrencyListServiceProtocol) {
        self.servicesProvider = servicesProvider
        servicesProvider.fetchCurrencyList { response in
            switch response {
            case .failure:
                self.currencyList = nil
            case .success(let data):
                self.currencyList = data.currencies?.sorted { $0.key < $1.key }
            }
        }
    }

}

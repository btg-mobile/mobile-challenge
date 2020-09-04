//
//  CurrencyListViewModel.swift
//  BTG mobile challange
//
//  Created by Uriel Barbosa Pinheiro on 03/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

class CurrencyListViewModel {

    var currencyList: [Dictionary<String, String>.Element]?

    private let serviceProvider: CurrencyListServiceProtocol

    init(servicesProvider: CurrencyListServiceProtocol) {
        self.serviceProvider = servicesProvider
        serviceProvider.fetchCurrencyList { response in
            switch response {
            case .failure(let error):
                #if DEBUG
                print(error)
                #endif
            case .success(let data):
                self.currencyList = data.currencies?.sorted { $0.key < $1.key }
            }
        }
    }

}

//
//  CurrencyListViewModel.swift
//  BTG Mobile Challange
//
//  Created by Uriel Barbosa Pinheiro on 23/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

public class CurrencyListViewModel {

    // MARK: - Bindable variables

    @Published var currencyList: [Dictionary<String, String>.Element]?

    // MARK: - Constants

    private let servicesProvider: CurrencyListServiceProtocol

    // MARK: - Lyfecycle and constructors

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

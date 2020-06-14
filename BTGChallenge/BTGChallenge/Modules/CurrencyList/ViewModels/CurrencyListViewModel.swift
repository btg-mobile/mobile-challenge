//
//  CurrencyListViewModel.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 14/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

protocol CurrencyListViewModelContract {
    func fetch(completion: @escaping(Result<[CurrencyListViewData]>) -> Void)
}

class CurrencyListViewModel: CurrencyListViewModelContract {

    let service: CurrencyListServiceContract
    
    init(service: CurrencyListServiceContract) {
        self.service = service
    }
    
    func fetch(completion: @escaping (Result<[CurrencyListViewData]>) -> Void) {
        self.service.fetch { result in
            switch result {
            case .success(let model):
                let viewData = self.formartList(currencies: model.currencies.CurrenciesDict)
                completion(.success(viewData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func formartList(currencies: [String: String?]) -> [CurrencyListViewData]{
        return currencies.compactMap { element in
            guard let value = element.value else { return nil }
            let formattedCurrency = CurrencyListViewData(currencyCode: element.key, currencyName: value)
            return formattedCurrency
            
        }.sorted(by: { $0.currencyCode < $1.currencyCode })
    }
}

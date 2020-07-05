//
//  HomeInteractor.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

class HomeInteractor: HomeInteractorInput {
    
    weak var output:HomeInteractorOutput?
    var manager: CurrencyManager
    
    init(manager: CurrencyManager) {
        self.manager = manager
    }
    func loadRequest() {
        manager.fetchList { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let list):
                strongSelf.currencyQuotes(list: list)
            case .failure(let error):
                dump(error)
            }
        }
    }
    
    func currencyQuotes(list: ListCurrenciesModel) {
        manager.currencyQuotes { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
    
            case .success(let listQuotes):
                strongSelf.output?.fetched(entites: HomeEntityMapper.mappingListCurrency(listCurrency: list, listQuotes: listQuotes))
            case .failure(let error):
                dump(error)
            }
        }
    }
    
}


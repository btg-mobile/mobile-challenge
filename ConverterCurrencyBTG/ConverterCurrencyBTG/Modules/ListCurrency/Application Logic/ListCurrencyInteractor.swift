//
//  ListCurrencyInteractor.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

class ListCurrencyInteractor: ListCurrencyInteractorInput {
    weak var output: ListCurrencyInteractorOuput?
    var manager: CurrencyManager
    var entites: [HomeEntity] = [HomeEntity]()
    
    
    init(manager: CurrencyManager) {
        self.manager = manager
    }
    
    func loadData() {
        
        manager.fetchList { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
                
            case .success(let list):
                strongSelf.loadRequestQuotes(listModel: list)
            case .failure(let error):
                dump(error)
            }
        }
    }
    
    func loadRequestQuotes(listModel: ListCurrenciesModel){
        manager.currencyQuotes { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
                
            case .success(let listQuotes):
                strongSelf.entites = HomeEntityMapper.mappingListCurrency(listCurrency: listModel, listQuotes: listQuotes)
                strongSelf.output?.fetched(entites: strongSelf.entites)
            case .failure(let error):
                dump(error)
            }
        }
    }
}

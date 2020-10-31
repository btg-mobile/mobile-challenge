//
//  CurrencyListViewModel.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation

protocol CurrencyListViewModelDelegate: class {
    func willLoadData()
    func didLoadData(message: String?)
}


class CurrencyListViewModel {
    
    var currencyButtonType: CurrencyButtonType
    weak var delegate: CurrencyListViewModelDelegate?
    var currencies: [Currency]
    
    init(currencyButtonType: CurrencyButtonType){
        self.currencyButtonType = currencyButtonType
        self.currencies = []
    }
    
    func loadData(){
        self.delegate?.willLoadData()
        let currencyClient = CurrencyClient(session: URLSession.shared)
        currencyClient.getListOfCurrencies { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            
            case .success(let currencies):
                guard let currencies = currencies.currencies else { return }
                for (key, value) in currencies {
                    self.currencies.append(Currency(name: value, code: key))
                }
                self.delegate?.didLoadData(message: nil)
            case .failure(let error):
                print(error.description)
                self.delegate?.didLoadData(message: error.description)

            }
        }
    }

    
    
}

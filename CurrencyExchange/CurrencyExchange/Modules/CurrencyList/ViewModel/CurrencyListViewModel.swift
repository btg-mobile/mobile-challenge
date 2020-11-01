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
        
        currencyClient.getLiveCurrencies { [weak self] (resultOfLiveCurrencies) in
            guard let self = self else { return }
            switch resultOfLiveCurrencies {
            
            case .success(let liveCurrencies):
                
                currencyClient.getListOfCurrencies { [weak self] (result) in
                    guard let self = self else { return }
                    switch result {
        
                    case .success(let currencies):
                        guard let currencies = currencies.currencies else { return }
                        for (code, name) in currencies {

                            if let currencyValue = liveCurrencies.quotes?["USD\(code)"]{
                                self.currencies.append(Currency(name: name, code: code, value: Double(currencyValue)))
                            }else {
                                self.currencies.append(Currency(name: name, code: code))
                            }
                            
                        }
                        
                        self.delegate?.didLoadData(message: nil)
                    case .failure(let error):
                        self.delegate?.didLoadData(message: error.description)
        
                    }
                }
                
            case .failure(let error):
                self.delegate?.didLoadData(message: error.description)
            }
        }
    }

    
    private func loadDataWhenNetworkIsAvailable(){
        
    }
    
    
}

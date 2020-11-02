//
//  CurrencyListViewModel.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation
import CoreData

protocol CurrencyListViewModelDelegate: class {
    func willLoadData()
    func didLoadData(message: String?)
}


class CurrencyListViewModel {
    
    var currencyButtonType: CurrencyButtonType
    weak var delegate: CurrencyListViewModelDelegate?
    var currencies: [Currency]
    var currencyDAO: CurrencyDAO
    
    init(currencyButtonType: CurrencyButtonType, coreDataStack: CoreDataStack){
        self.currencyButtonType = currencyButtonType
        self.currencies = []
        self.currencyDAO =  CurrencyDAO(coreDataStack: coreDataStack)
    }
    
    func loadData(){
        
    }

    
    private func loadDataWhenNetworkIsAvailable(){
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
                                
                                let currency = Currency(name: name, code: code, value: Double(currencyValue))
                                self.currencies.append(currency)
                                
                                self.currencyDAO.createWithCurrency(currency)
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
    
    
}

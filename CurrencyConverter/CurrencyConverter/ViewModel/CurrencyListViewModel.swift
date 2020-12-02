//
//  CurrencyListViewModel.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import Foundation

protocol CurrencyListViewModelDelegate: class {
    func didReceiveCurrencies()
    func didReceiveError(error: Error)
}

class CurrencyListViewModel {
    // MARK: - Properties
    private let currencyAPI = CurrencyAPIService()
    var currencies: [Currency]
    
    weak var delegate: CurrencyListViewModelDelegate?
    
    
    // MARK: - Initialization
    init(currencies: [Currency]? = nil) {
        if let inputCurrencies = currencies {
            self.currencies = inputCurrencies
        } else {
            self.currencies = []
        }
    }
}


// MARK: - Fetch and Search Methods
extension CurrencyListViewModel {
    func fetchCurrencies() {
        currencyAPI.fetchAllCurrencies(completionHandler: { [weak self] result in
            switch result {
            case .failure(let error):
                self?.handleErrors(error: error)
            
            case .success(let receivedCurrencies):
                self?.currencies = receivedCurrencies
                self?.sortCurrenciesByCode()
                self?.delegate?.didReceiveCurrencies()
                break
            }
        })
    }
}

// MARK: - Sort Method
extension CurrencyListViewModel {
    private func sortCurrenciesByCode() {
        self.currencies.sort(by: {
            $0.code < $1.code
        })
    }
}


// MARK: - Handle Erros
extension CurrencyListViewModel {
    private func handleErrors(error: Error) {
        print("Error: ", error)
    }
}

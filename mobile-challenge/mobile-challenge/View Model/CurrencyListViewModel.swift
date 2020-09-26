//
//  CurrencyListViewModel.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

enum OrderButtonTitle: String {
    case name = "Ordem: Nome"
    case code = "Ordem: Código"
}

protocol CurrencyListViewModelDelegate: AnyObject {
    func didFinishLoadCurrenciesWithSuccess(_ currencies: [CurrencyModel])
}

class CurrencyListViewModel {
    var currencies: [CurrencyModel] = []
    private let networkManage = NetworkManage()
    
    weak var delegate: CurrencyListViewModelDelegate?
    
    init() {
        fetchCurrencies()
    }
    
    func fetchCurrencies() {
        let service = ConverterService.currencyList
        
        networkManage.request(service: service, resposeType: CurrencyListResponse.self) { result in
            switch result {
            case .success(let currenciesListResponse):
                guard let currencies = currenciesListResponse.currencies else { return }
                for (key, value) in currencies {
                    self.currencies.append(CurrencyModel(code: key, name: value))
                }
                self.currencies.sort{ $0.code < $1.code }
                self.delegate?.didFinishLoadCurrenciesWithSuccess(self.currencies)
            case .failure:
                print("Falhou ao buscar moedas")
            }
        }
    }
}

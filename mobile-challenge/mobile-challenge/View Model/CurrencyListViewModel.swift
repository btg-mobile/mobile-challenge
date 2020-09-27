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
    func didFinishLoadCurrencyListWithSuccess(_ currencies: [CurrencyModel])
    func didFinishLoadCurrencyValuesInDollarWithSuccess(_ currencies: [CurrencyModel])
}

class CurrencyListViewModel {
    var currencies: [CurrencyModel] = []
    private let networkManage = NetworkManage()
    
    weak var delegate: CurrencyListViewModelDelegate?
    
    init() {
    }
    
    func fetchCurrencies(errorHandler: @escaping (String?) -> Void) {
        let service: ConverterService = .currencyList
        
        networkManage.request(service: service, resposeType: CurrencyListResponse.self) { result in
            switch result {
            case .success(let currenciesListResponse):
                guard let currencies = currenciesListResponse.currencies else { return }
                for (key, value) in currencies {
                    self.currencies.append(CurrencyModel(code: key, name: value))
                }
                self.currencies.sort{ $0.code < $1.code }
                self.delegate?.didFinishLoadCurrencyListWithSuccess(self.currencies)
                self.fetchValuesInDollar()
                errorHandler(nil)
            case .failure(let error):
                errorHandler(error.errorDescription)
            }
        }
    }
    
    func fetchValuesInDollar() {
        let service: ConverterService = .liveConverter
        
        networkManage.request(service: service, resposeType: CurrencyExchangeResponse.self) { result in
            switch result {
            case .success(let currencyExchangeResponse):
                guard let currenciesExchange = currencyExchangeResponse.quotes else { return }
                for (key, value) in currenciesExchange {
                    if let index = self.currencies.firstIndex(where: { key == "USD\($0.code)" }) {
                        self.currencies[index].valueDollar = value
                        self.currencies[index].date = Date(timeIntervalSince1970: currencyExchangeResponse.timestamp)
                    }
                }
                self.delegate?.didFinishLoadCurrencyValuesInDollarWithSuccess(self.currencies)
            case .failure:
                print("Falha ao buscar valor das moedas em dolar")
            }
        }
    }
}

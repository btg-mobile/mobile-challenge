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
    var currenciesBackup: [CurrencyModel] = []
    var dateExchange: Date?
    private let networkManage = NetworkManage()
    
    weak var delegate: CurrencyListViewModelDelegate?
    
    let dao = CurrencyDAO()
    
    init() {
        self.orderCurrencies(by: .code)
    }
    
    func orderCurrencies(by: OrderButtonTitle) {
        switch by {
        case .code:
            currencies.sort { $0.code < $1.code }
        case .name:
            currencies.sort { $0.name < $1.name }
        }
    }
    
    func fetchCurrencies(errorHandler: @escaping (NetworkError?) -> Void) {
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
                errorHandler(error)
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
                    }
                }
                self.dateExchange = Date(timeIntervalSince1970: currencyExchangeResponse.timestamp)
                self.currenciesBackup = self.currencies
                self.delegate?.didFinishLoadCurrencyValuesInDollarWithSuccess(self.currencies)
                self.saveCurrencies()
            case .failure:
                print("Falha ao buscar valor das moedas em dolar")
            }
        }
    }
    
    func saveCurrencies() {
        guard let date = dateExchange else { return }
        dao.save(currencies: currencies, dateExchange: date)
    }
    
    func retrieveCurrencies() -> Bool {
        let result:(currencies: [CurrencyModel], date: Date) = dao.retrieve()
        if result.currencies.count > 0 {
            currencies = result.currencies
            dateExchange = result.date
            return true
        }
        else {
            return false
        }
    }
}

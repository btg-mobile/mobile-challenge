//
//  QuotationViewModel.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import Foundation

class QuotationViewModel {
    
    var quotation: Quotation?
    var currency: Currency?
    var currenciesQuotation: [CurrencyQuotation] = []
    var manager: NetworkManager
    var group = DispatchGroup()
    var queue = DispatchQueue.global()
    
    init(manager: NetworkManager) {
        self.manager = manager
    }
}

extension QuotationViewModel {
    func getCurrenciesQuotation(completion: @escaping (Result<[CurrencyQuotation], Error>)-> Void) {
        
        queue.async {
            self.fetchCurrencies { (error) in
                if let error = error {
                    completion(.failure(error))
                }
                self.group.leave()
            }
            
            self.fetchQuotation { (error) in
                if let error = error {
                    completion(.failure(error))
                }
                self.group.leave()
            }
            
            self.group.notify(queue: self.queue){
                self.groupCurrencyQuotationInfo()
                completion(.success(self.currenciesQuotation))
            }
        }
    }
    
    func fetchQuotation(completion: @escaping (Error?)->()) {
        group.enter()
        manager.request(service: NetworkServiceType.live, model: Quotation.self) { (result) in
            switch result {
            case .success(let quotation):
                self.quotation = quotation
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func fetchCurrencies(completion: @escaping (Error?)->()) {
        group.enter()
        manager.request(service: .list, model: Currency.self) { (result) in
            switch result {
            case .success(let currency):
                self.currency = currency
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func groupCurrencyQuotationInfo() {
        guard let currencies = currency?.currencies else { return }
        guard let quotation = quotation?.quotes else { return }
        for (key, value) in currencies {
            let quoteKey = "USD\(key)"
            guard let quote = quotation[quoteKey] else { return }
            
            let currencyQuotation = CurrencyQuotation(code: key, currency: value, quotation: quote)
            self.currenciesQuotation.append(currencyQuotation)
        }
    }
}

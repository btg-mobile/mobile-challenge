//
//  CurrencyLayerService.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
class CurrencyLayerService: CurrencyLayerServiceProtocol {
    
    let httpManager: HTTPManager<CurrencyRouter>
    let storage: StorageProtocol
    
    init(httpManager: HTTPManager<CurrencyRouter>, storage: StorageProtocol = Storage()) {
        self.httpManager = httpManager
        self.storage = storage
    }
    
    func getCurrenciesList(onCompletion: @escaping((CurrencyListResult) -> Void)) {
        httpManager.request(router: .list) { (result: CurrencyListResult) in
            if let unwrappedResult = result.result, unwrappedResult.success! {
                self.storage.saveCurrencyList(response: unwrappedResult)
            }
            
            onCompletion(result)
        }
    }
    
    func getConversionRate(fromCoin: String, toCoin: String, onCompletion: @escaping ((CurrencyLiveResult) -> Void)) {
        httpManager.request(router: .live(fromCoin, toCoin)) { (result: CurrencyLiveResult) in
            if let unwrappedResult = result.result, unwrappedResult.success! {
                self.storage.saveCurrentRate(response: unwrappedResult)
            }
            onCompletion(result)
        }
    }
    
    
    
}

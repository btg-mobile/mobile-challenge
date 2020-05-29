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
    
    init(httpManager: HTTPManager<CurrencyRouter>) {
        self.httpManager = httpManager
    }
    
    func getCurrenciesList(onCompletion: @escaping((CurrencyListResult) -> Void)) {
        
        httpManager.request(router: .list) { (result: CurrencyListResult) in
            onCompletion(result)
        }
        
    }
}

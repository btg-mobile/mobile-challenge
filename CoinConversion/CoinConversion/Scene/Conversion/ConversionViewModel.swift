//
//  ConversionViewModel.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

// MARK: - ConversionViewModelDelegate
protocol ConversionViewModelDelegate: class {
    
}

// MARK: - Main
class ConversionViewModel {
    weak var delegate: ConversionViewModelDelegate?
    
    private var service: CurrenciesConversionService?
    private var router: ConversionRouter?
    
    init(service: CurrenciesConversionService, router: ConversionRouter) {
        self.service = service
        self.router = router
    }
    
    func fetchQuotes()  {
        service?.fetchQuotes(success: { currenciesConversion in
            print(currenciesConversion)
        }, fail: { serviceError in
            print(serviceError)
        })
    }
}

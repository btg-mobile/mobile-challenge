//
//  ConversionViewModel.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

// MARK: - Conversion
enum Conversion {
    case to
    case from
}

// MARK: - ConversionViewModelDelegate
protocol ConversionViewModelDelegate: class {
    func didSetTitle(_ title: String?)
    func didSetBarButton()
    func didStartLoading()
    func didHideLoading()
    func didReloadData()
    func didFail()
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
}

// MARK: - Custom methods
extension ConversionViewModel {
    func setInitialInformation() {
        delegate?.didSetTitle("Conversão")
        delegate?.didSetBarButton()
    }
    
    func fetchQuotes()  {
        service?.fetchQuotes(success: { currenciesConversion in
            print(currenciesConversion)
        }, fail: { serviceError in
            print(serviceError)
        })
    }
    
    func fetchCurrencies(_ conversion: Conversion) {
        router?.enqueueListCurrencies(conversion)
    }
}

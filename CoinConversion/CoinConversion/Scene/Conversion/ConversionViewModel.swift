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
    func didStartLoading()
    func didHideLoading()
    func didReloadData(code: String, name: String, conversion: Conversion)
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
        self.router?.delegate = self
    }
}

// MARK: - Custom methods
extension ConversionViewModel {    
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

// MARK: - Custom methods
extension ConversionViewModel: ConversionRouterDelegate {
    func currencyFetched(_ code: String, _ name: String, _ conversion: Conversion) {
        delegate?.didReloadData(code: code, name: name, conversion: conversion)
    }
}

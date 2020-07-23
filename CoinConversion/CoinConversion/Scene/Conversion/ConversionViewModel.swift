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
    func didUpdateDate(with date: String)
    func didReloadData(code: String, name: String, conversion: Conversion)
    func didReloadResult(with value: String, color: UIColor)
    func didFail()
}

// MARK: - Main
class ConversionViewModel {
    weak var delegate: ConversionViewModelDelegate?
    
    private var service: CurrenciesConversionService?
    private var router: ConversionRouter?
    private var conversionModel: ConversionModel?
    private var dataManager: DataManager?
    
    init(
        service: CurrenciesConversionService,
        dataManager: DataManager,
        router: ConversionRouter
    ) {
        self.service = service
        self.dataManager = dataManager
        self.dataManager?.delegate = self
        self.router = router
        self.router?.delegate = self
    }
}

// MARK: - Custom methods
extension ConversionViewModel {
    func fetchQuotes(isRefresh: Bool) {
        if !hasDatabaseQuotes() || isRefresh {
            delegate?.didStartLoading()
            
            service?.fetchQuotes(success: { currenciesConversion in
                self.delegate?.didHideLoading()
                
                self.conversionModel = self.handleConversionQuotes(
                    with: currenciesConversion
                )
                self.delegate?.didUpdateDate(
                    with: self.conversionModel?.date?.getDateStringFromUTC() ?? "-"
                )
                
                self.dataManager?.syncQuotes(with: self.conversionModel!)
                
            }, fail: { serviceError in
                self.delegate?.didHideLoading()
                self.delegate?.didFail()
                
                print(serviceError)
            })
        }
    }
    
    func fetchCurrencies(_ conversion: Conversion) {
        router?.enqueueListCurrencies(conversion)
    }
    
    func convertCurrency(fromCode: String, toCode: String, value: String) {
        guard let conversion = conversionModel?.conversion else {
            return
        }
        
        let currencyBase = "USD"
        
        guard let fetchFromQuotes = returnQuotes(
            conversion: conversion,
            currencyBase: currencyBase,
            code: fromCode) else {
                
                didConversionFail()
                return
        }
        
        guard let fetchToQuotes = returnQuotes(
            conversion: conversion,
            currencyBase: currencyBase,
            code: toCode) else {
                
                didConversionFail()
                return
        }
        
        guard let toQuotes = fetchToQuotes.quotes,
            let fromQuotes = fetchFromQuotes.quotes else {
                didConversionFail()
                return
        }
        
        if let value = Double(value) {
            var amount: Double = 0.0
            amount =  value * toQuotes / fromQuotes
            
            guard let result = formatCurrency(
                currencyCode: toCode,
                amount: String(amount)) else {
                    
                    didConversionFail()
                    return
            }
            
            delegate?.didReloadResult(
                with: result,
                color: .colorSpringGreen
            )
            return
        }
        
        if !value.isEmpty {
            didConversionFail()
            return
        }
        
        delegate?.didReloadResult(
            with: "-",
            color: .clear
        )
    }
    
    func formatCurrency(
        currencyCode: String,
        amount: String
    ) -> String? {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = findLocaleBy(whit: currencyCode)
        
        let numberFromField = (
            NSString(string: amount).doubleValue
            )/100
        let result = formatter.string(
            from: NSNumber(value: numberFromField)
            )!
        return result
    }
}

// MARK: - PrivateMethods
extension ConversionViewModel {
    private func handleConversionQuotes(
        with currenciesConversion: CurrenciesConversion
    ) -> ConversionModel {
        
        let currencies = currenciesConversion.quotes.map {
            currencies -> ConversionCurrenciesModel in
            
            return ConversionCurrenciesModel(
                code: currencies.key,
                quotes: currencies.value
            )
        }
        
        return ConversionModel(date: currenciesConversion.timestamp, conversion: currencies)
    }
    
    private func returnQuotes(
        conversion: [ConversionCurrenciesModel],
        currencyBase: String,
        code: String
    ) -> ConversionCurrenciesModel? {
        
        if let quotes = conversion.first(
            where: { $0.code == currencyBase + code }
            ) {
            return quotes
        }
        
        return nil
    }
    
    private func findLocaleBy(
        whit currencyCode: String
    ) -> Locale? {
        
        let locales = Locale.availableIdentifiers
        var locale: Locale?
        
        for localeId in locales {
            locale = Locale(identifier: localeId)
            
            if let code = (locale! as NSLocale).object(forKey: NSLocale.Key.currencyCode) as? String {
                if code == currencyCode {
                    return locale
                }
            }
        }
        
        return locale
    }
    
    private func didConversionFail() {
        delegate?.didReloadResult(
            with: "Ops... Aconteceu um erro na conversão",
            color: .colorDarkRed
        )
    }
    
    private func hasDatabaseQuotes() -> Bool {
        if dataManager?.hasDatabaseQuotes() ?? false {
            conversionModel = dataManager?.fetchDatabaseQuotes()
            guard let conversion = conversionModel else {
                fatalError("provisorio fazer tratamento")
            }
            delegate?.didUpdateDate(
                with: conversion.date?.getDateStringFromUTC() ?? "-"
            )
            return true
        }
        return false
    }
}

// MARK: - ConversionRouterDelegate
extension ConversionViewModel: ConversionRouterDelegate {
    func currencyFetched(_ code: String, _ name: String, _ conversion: Conversion) {
        delegate?.didReloadData(code: code, name: name, conversion: conversion)
    }
}

// MARK: - DataManagerDelegate
extension ConversionViewModel: DataManagerDelegate {
    func didDataManagerFail(with reason: String) {
        print(reason)
    }
}

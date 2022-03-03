//
//  ExchangeRateViewModel.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 02/03/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

// MARK: - Protocol

protocol ExchangeRateViewModelProtocol {
    
    // MARK: - Properties
    
    var currencyBaseCode:       Bindable<String> { get }
    var currencyEchangedCode:   Bindable<String> { get }
    var currencyEchangedRate:   Bindable<Decimal> { get }
    var resultAmountLabel:      Bindable<String> { get }
    
    // MARK: - Methods
    
    func getData()
    func setSelectedCurrency(_ currency: CurrencyModel?)
}

// MARK: - Class

class ExchangeRateViewModel: ExchangeRateViewModelProtocol {
    
    // MARK: - Properties
    
    private let formatter = NumberFormatter()
    
    var currencyBaseCode:       Bindable<String>
    var currencyEchangedCode:   Bindable<String>
    var currencyEchangedRate:   Bindable<Decimal>
    var resultAmountLabel:      Bindable<String>
    
    private var baseAmount:         Decimal?
    private var currenciesList:     [CurrencyModel] = []
    private var currenciesVO:       CurrenciesVO?
    private var currencyBase:       CurrencyModel?
    private var currencyExchanged:  CurrencyModel?
    private var exchangeRatesVO:    ExchangeRateVO?
    private var isBase:             Bool?
    
    private var exchangeRate:       Decimal {
        return (currencyExchanged?.value ?? Decimal.zero) / (currencyBase?.value ?? Decimal(1.00))
    }
    
    // MARK: - Init's
    
    init() {
        currencyBaseCode        = Bindable<String>  ()
        currencyEchangedCode    = Bindable<String>  ()
        currencyEchangedRate    = Bindable<Decimal> ()
        resultAmountLabel       = Bindable<String>  ()
    }
    
    // MARK: - Methods
    
    func getData() {
        //  Exchange Rate
        NetworkManager.shared.getExchange { success, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let response = response, success else { return }
            self.exchangeRatesVO = response
            
        }
        
        //  Curencies
        NetworkManager.shared.getCurrencies { success, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let response = response, success else { return }
            self.currenciesVO = response
            
            self.concatenateValues()
        }
        
    }
    
    private func concatenateValues() {
        
        guard let exchangeVO = exchangeRatesVO, let currenciesVO = currenciesVO else {
            return
        }
        
        let currenciesList: [CurrencyModel] = exchangeVO.quotes.compactMap({ quote in
            let code = quote.key.replacingOccurrences(of: "USD", with: "")
            let currency = CurrencyModel(code: code, name: currenciesVO.currencies[code] ?? "", value: Decimal(quote.value))
            
            return currency
        })
        
        self.currenciesList = currenciesList
    }
    
    func getCurrenciesList() -> [CurrencyModel] {
        return self.currenciesList
    }
    
    func setSelectedCurrency(_ currency: CurrencyModel?) {
        guard let currency = currency else { return }
        setTableViewCell(currency)
    }
    
    func setTableViewCell(_ currency: CurrencyModel?) {
        guard let isBase = isBase else { return }
        
        if isBase {
            currencyBase = currency
            currencyBaseCode.value = currency?.code
        } else {
            currencyExchanged = currency
            currencyEchangedCode.value = currencyExchanged?.code
        }
        
        currencyEchangedRate.value = exchangeRate
    }
    
    func setAsBaseCell(_ row: Int) {
        row == 0 ? (isBase = true) : (isBase = false)
    }
    
    func setBaseAmount(_ amount: String?) {
        guard let amount = amount else { return }
        baseAmount = Decimal(string: amount)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.usesGroupingSeparator = true
        
        guard let baseAmount = baseAmount else {
            resultAmountLabel.value = "-"
            return
        }
        
        if let result = formatter.string(from: (baseAmount * exchangeRate).doubleValue as NSNumber){
            resultAmountLabel.value = result
        }
    }
    
}

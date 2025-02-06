//
//  ViewControllerViewModel.swift
//  mobileChallenge
//
//  Created by Henrique on 03/02/25.
//

import Foundation

class HomeControllerViewModel {
    var onCurrencyUpdated: (()->Void)?
    var onErrorMessage: ((CurrencyServiceError)->Void)?
    
    var firstCurrencyValue: Double = 5.342801
    var secondCurrencyValue: Double = 1
    
    private(set) var currency: [CurrencyName] = [] {
        didSet {
            if !currencyConversion.isEmpty{
                self.onCurrencyUpdated?()
            }
        }
    }
    private(set) var currencyConversion: [CurrencyConversionName] = [] {
        didSet {
            if !currency.isEmpty{
                self.onCurrencyUpdated?()
            }
        }
    }
    
    public func fetchAPI(){
        Task{
            await fetchAllData()
        }
    }
    
    private func fetchAllData() async {
        await withTaskGroup(of: Void.self){ group in
            group.addTask {
                self.fetchCurrency()
            }
            group.addTask {
                self.fetchCurrencyConversion()
            }
        }
    }
    
    public func fetchCurrency(){
        let endpoint = Endpoint.fetchCurrency()
        ApiService.fetchData(with: endpoint, modelType: Currency.self){ [weak self] result in
            switch result{
            case .success(let currency):
                var currencyArray = currency.currencies.map { CurrencyName(code: $0.key, name: $0.value) }
                currencyArray.sort {
                    $0.code < $1.code
                }
                self?.currency = currencyArray
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
            
        }
    }
    public func fetchCurrencyConversion(){
        let endpoint = Endpoint.fetchCurrencyConversion()
        ApiService.fetchData(with: endpoint, modelType: CurrencyConversion.self){ [weak self] result in
            switch result {
            case .success(let currencyConversion):
                var currencyConversionArray = currencyConversion.quotes.map { CurrencyConversionName(code: $0.key, value: $0.value) }
                currencyConversionArray.sort {
                    $0.code < $1.code
                }
                self?.currencyConversion = currencyConversionArray
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
    
    public func calculateConversion(value: Double)->Double{
        let toUSD = value /  self.firstCurrencyValue
        let toConvert = toUSD * self.secondCurrencyValue
        return toConvert
    }
    
    public func invertCurrencies(){
        let temp = self.firstCurrencyValue
        self.firstCurrencyValue = self.secondCurrencyValue
        self.secondCurrencyValue = temp
    }
}

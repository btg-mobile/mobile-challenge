//
//  CurrencyViewModel.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 01/04/21.
//

import Foundation

protocol DataDelegete {
    func gettingCountryOne(countryOne: String)
    func gettingCountryTwo(countryTwo: String)
}

final class CurrencyViewModel: DataDelegete {
    
    var countrySelectedOne: String?
    var countrySelectedTwo: String?
    
    func gettingCountryOne(countryOne: String) {
        self.countrySelectedOne = countryOne
    }
    
    func gettingCountryTwo(countryTwo: String) {
        self.countrySelectedTwo = countryTwo
    }
    
    private let apiCurrentValue: RealTimeRatesApiProtocol
    private var modelValue: RealTimeRatesModel?
    
    private let api: CurrencyListModelProtocol
    private var model: CurrencyListModel?
    
    init(api: CurrencyListModelProtocol = RequestApi(), apiCurrentValue: RealTimeRatesApiProtocol = RequestApi()) {
        self.api = api
        self.apiCurrentValue = apiCurrentValue
    }
    
    var modelDetails: CurrencyListModel? {
        return model
    }
    
    var modelCurrentValue: RealTimeRatesModel?  {
        return modelValue
    }
    
    func convertDicKeyToArray() -> [String] {
        let names = model?.currencies.map { return $0.key }
        return names ?? []
    }
    
    func convertDicValueToArray() -> [String] {
        let names = model?.currencies.map { return $0.value }
        return names ?? []
    }
    
    func fetchDetails(_ completion: @escaping (Bool) -> Void) {
        api.fetchCurrencyList { statusCode, model in
            guard let statusCode = statusCode else { return }
            if ConnectionErrorManager.isSuccessfulStatusCode(statusCode: statusCode) {
                guard let model = model else { return }
                self.model = model
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func fetchCurrentValue(_ completion: @escaping (Bool) -> Void) {
        apiCurrentValue.fetchRealTimeRates { statusCode, model in
            guard let statusCode = statusCode else { return }
            if ConnectionErrorManager.isSuccessfulStatusCode(statusCode: statusCode) {
                guard let model = model else { return }
                self.modelValue = model
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func loadCurrencyData(ofCurrency: String, toCurrency: String, value: Double, completionHendler: @escaping (Double?) -> Void) {
        var finalResult = 0.0
        
        modelValue?.quotes.forEach {
            if "USD\(ofCurrency)" == $0.key {
                finalResult = value / $0.value
            }
        }
        modelValue?.quotes.forEach {
            if "USD\(toCurrency)" == $0.key {
                finalResult = finalResult * $0.value
            }
        }
        completionHendler(finalResult)
    }
}
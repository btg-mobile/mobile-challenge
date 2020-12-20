//
//  CurrencyConverterViewModel.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import Foundation

final class CurrencyConverterViewModel: CurrencyConverterViewModeling {    
    
    typealias Currency = [String: Double]
    
    weak var delegate: CurrencyConverterViewModelDelegate?
    
    var convertedAmount: String = "" 
                
    var fromCurrencyValue: String? {
        didSet {
            toCurrencyValue = convert(amount: fromCurrencyValue ?? "")
        }
    }
    
    var fromCurrencyCode: String = "USD" {
        didSet {
            fetchCurrencyLiveQuote()
        }
    }
    
    var fromCurrencyName: String = "United States Dollar" {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.delegate?.updateUI()
            }
        }
    }

    var toCurrencyValue: String? = "0.00" {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.delegate?.updateUI()
            }
        }
    }
    
    var toCurrencyCode: String = "BRL" {
        didSet {
            fetchCurrencyLiveQuote()
        }
    }
    
    var toCurrencyName: String = "Brazilian Real" {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.delegate?.updateUI()
            }
        }
    }
    
    private let requestManager: RequestManager
    private let coordinator: CurrencyConverterCoordinator
    
    private var currency: Currency = [:]
    private var listResponse: CurrencyResponseFromList?
    
    init(requestManager: RequestManager, coordinator: CurrencyConverterCoordinator) {
        self.requestManager = requestManager
        self.coordinator = coordinator
    }
    
    func fetchCurrencyLiveQuote() {
        
        guard let url = CurrencyAPIEndpoint.live.url else {
            return
        }
        
        self.requestManager.getRequest(url: url, decodableType: CurrencyReponseFromLive.self) { [weak self] (response) in
            switch response {
            case .success(let result):
                let fetchedCurrency = result.quotes
                self?.currency = fetchedCurrency
            //TODO
            case .failure(let error):
                print("TODO")
            }
        }
    }
    
    func convert(amount: String) -> String {
        
        guard let doubleValue = Double(amount) else {
            return "0"
        }
        
        if fromCurrencyCode == "USD" {
            return convertFromUSD(amount: doubleValue)
        }
        
        if toCurrencyCode == "USD" {
            return convertToUSD(amount: doubleValue)
        }
        
        guard let currencyValueFromUSD = currency[fromCurrencyCode] else {
            return ""
        }
        
        guard let currencyValueToUSD = currency[toCurrencyCode] else {
            return ""
        }
        
        let convertedValue = (currencyValueToUSD/currencyValueFromUSD) * doubleValue
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = fromCurrencyCode
        
        return numberFormatter.string(from: NSNumber(value: convertedValue)) ?? ""
    }
    
    func convertFromUSD(amount: Double) -> String {
        guard let USDValue = currency["\(fromCurrencyCode)" + "\(toCurrencyCode)"] else {
            return ""
        }
        
        let currencyValue = 1/USDValue
        let convertedValue = amount * currencyValue
        
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = fromCurrencyCode
        
        numberFormatter.string(from: NSNumber(value: convertedValue))
        numberFormatter.numberStyle = .currencyISOCode
        
        return numberFormatter.string(from: NSNumber(value: convertedValue)) ?? ""
    }
    
    func convertToUSD(amount: Double) -> String {
        guard let USDValue = currency[toCurrencyCode] else {
            return ""
        }
        
        let convertedValue = amount * USDValue
        
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = fromCurrencyCode
        numberFormatter.numberStyle = .currencyISOCode
        
        return numberFormatter.string(from: NSNumber(value: convertedValue)) ?? ""
    }
    
    func swapCurrencies() {
        let lastCurrencyCode = fromCurrencyCode
        let lastCurrencyName = fromCurrencyName
        
        fromCurrencyCode = toCurrencyCode
        toCurrencyCode = lastCurrencyCode
        
        fromCurrencyName = toCurrencyName
        toCurrencyName = lastCurrencyName
    }
}

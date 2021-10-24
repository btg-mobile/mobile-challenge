//
//  BTGCurrencyConverterViewModel.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 21/10/21.
//

import Foundation


class BTGCurrencyConverterViewModel {
    
    weak var coordinatorDelegate: BTGAppCoordinatorDelegate?
    
    var fromCurrency: String = ""
    var toCurrency: String = ""
    var currencyValue = 0.0
    
    var currentValue: Float = 0 {
        didSet {
            self.value(value: currentValue)
        }
    }
    
    var currentCurrencyEdit: CurrencyType?
    var quotes: [Quotes] = []
    
    var didShowConvertedValue: ((String)-> Void)?
    var didShowError: ((String)-> Void)?
    
    let repository: CurrencyRepositoryProtocol
    
    init(repository: CurrencyRepositoryProtocol) {
        self.repository = repository
        
        fetchQuotes()
    }
    
    func fetchQuotes() {
        self.repository.quotes { [unowned self] quotes in
            self.quotes = quotes
            self.value(value: currentValue)
        } fail: { [unowned self] error in
            //self.didShowError?(error)
        }
    }
    
    func findQuote(code: String)-> Quotes? {
        guard let quote = quotes.first(where: { $0.code == "USD" + code } ) else {
            return nil
        }

        return quote
    }
    
    func calculate(value: Float)throws -> Float {
        guard let fromQuote = findQuote(code: fromCurrency) else { throw RuntimeError("Currency \(fromCurrency) not found") }
        guard let toQuote = findQuote(code: toCurrency) else { throw RuntimeError("Currency \(toCurrency) not found") }
        return CurrencyConverter.converter(fromQuote: fromQuote, toQuote: toQuote, value: value)
    }
    
    func value(value: Float) {
        do {
            let convertedValue = try calculate(value: value)
            didShowConvertedValue?(String(convertedValue))
        } catch let error as RuntimeError {
            print(error.message)
            didShowError?(error.message)
        } catch {
            print("Error \(error.localizedDescription)")
            // Catch any other errors
        }
    }
    
    func showPickSupporteds(type: CurrencyType) {
        currentCurrencyEdit = type
        coordinatorDelegate?.showPickerCurrencies()
    }
    
    func updateCurrency(currencyCode: String) {
        switch(currentCurrencyEdit) {
        case .to:
            toCurrency = currencyCode
        case .from:
            fromCurrency = currencyCode
        case .none: break
            
        }
    }
}

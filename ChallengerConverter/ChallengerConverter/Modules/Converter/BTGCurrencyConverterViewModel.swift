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
    
    var currentCurrencyEdit: EditingCurrencyType?
    var quotes: [Quotes] = []
    
    var didShowConvertedValue: ((String)-> Void)?
    var didShowError: ((String)-> Void)?
    var didShowErrorWithReload: ((String)-> Void)?
    var didEnableEdiValeu: ((Bool)-> Void)?
    var didShowSpinner: ((Bool)-> Void)?
    
    var didUpdateFromCurrency: ((String)-> Void)?
    var didUpdateToCurrency: ((String)-> Void)?
    
    let dataSource: CurrencyDatSourceProtocol
    
    init(dataSource: CurrencyDatSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func viewDidLoad() {
        fetchQuotes()
    }
    
    func fetchQuotes() {
        didShowSpinner?(true)
        self.dataSource.quotes { [unowned self] quotes in
            didShowSpinner?(false)
            
            self.quotes = quotes

            //Salva as cotas no bancp de dados
            LocalPreferencesDataBase.shared.save(model: quotes)

            self.value(value: currentValue)

        } fail: { [unowned self] error in
            didShowSpinner?(false)
            self.didShowErrorWithReload?(error+"Aqui")
        }
    }
    
//    func fetchCurrenciesAvaliable() {
//        self.dataSource.currenciesAvaliable {[unowned self] currencies in
//
//            //Salva a lista de moedas no Bando de Dados
//            LocalPreferencesDataBase.shared.save(model: currencies)
//            self.didShowSpinner?(false)
//        } fail: { [unowned self] error in
//            didShowSpinner?(false)
//            self.didShowErrorWithReload?(error+"Aqui A")
//        }
//    }
    
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
            if(!toCurrency.isEmpty && !fromCurrency.isEmpty) {
                let convertedValue = try calculate(value: value)
                didShowConvertedValue?(toCurrency + ": " + String(convertedValue))
            }
            
        } catch let error as RuntimeError {
            print(error.message)
            didShowError?(error.message)
        } catch {
            self.didShowError?(error.localizedDescription)
        }
    }
    
    func showPickSupporteds(type: EditingCurrencyType) {
        currentCurrencyEdit = type
        coordinatorDelegate?.showPickerCurrencies()
    }
    
    func updateCurrency(currencyCode: String) {
        switch(currentCurrencyEdit) {
        case .to:
            toCurrency = currencyCode
            didUpdateToCurrency?(currencyCode)
        case .from:
            fromCurrency = currencyCode
            didUpdateFromCurrency?(currencyCode)
        case .none: break
            
        }
        
        didEnableEdiValeu?(!toCurrency.isEmpty && !fromCurrency.isEmpty)
    }
    
    func updateConvertIfNecessary() {
        if(!toCurrency.isEmpty && !fromCurrency.isEmpty) {
            self.value(value: currentValue)
        }
    }
}

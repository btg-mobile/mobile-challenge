//
//  CurrencyConverterViewModel.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import Foundation

public struct ConvertResponse {
    let input: String
    let output: String
}

class CurrencyConverterViewModel {
    
    // MARK: Delegate
    weak var delegate: CurrencyConverterViewModelDelegate?
    
    // MARK: Variables
    private var quotes: CurrencyQuotes?
    
    private var currencyList: CurrencyList?
    
    private(set) var originCurrency: String = "" {
        didSet {
            delegate?.originChanged()
        }
    }
    private(set) var destinyCurrency: String = "" {
        didSet {
            delegate?.destinyChanged()
        }
    }
    
    private var isQuotesFetched: Bool = false {
        didSet {
            dataLoaded()
        }
    }
    private var isCurrenciesFetched: Bool = false {
        didSet {
            dataLoaded()
        }
    }
    
    private var currencyFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.positiveInfinitySymbol = "Valor inválido"
        numberFormatter.alwaysShowsDecimalSeparator = false
        numberFormatter.decimalSeparator = Locale.current.decimalSeparator
        numberFormatter.groupingSeparator = Locale.current.groupingSeparator
        return numberFormatter
    }()
    
    // MARK: Methods
    /**
     Call the methods to get the latests currencies and their respective quotes.
     */
    func start() {
        requestQuotes()
        requestCurrencyList()
    }
    
    /**
     Make the request to get the latests currencies quotes.
     */
    private func requestQuotes() {
        isQuotesFetched = false
        CurrencyService.getQuotes { (answer) in
            switch answer {
            case .result(let quotes as CurrencyQuotes):
                self.quotes = quotes
            case .error(_ as DataTaskError):
                self.delegate?.createAlert(title: "Ocorreu um erro", message: "Verifique o status da sua conexão.", handler: nil)
                self.quotes = nil
            case .error(let error as URLParsingError):
                self.delegate?.createAlert(title: "Erro \(error.code)", message: "Entre em contato com o administrador.", handler: nil)
                self.quotes = nil
            default:
                self.delegate?.createAlert(title: "Erro genérico", message: "Entre em contato com o administrador.", handler: nil)
                self.quotes = nil
            }
            self.isQuotesFetched = true
        }
    }
    
    /**
     Make the request to get the available currencies.
     */
    private func requestCurrencyList() {
        isCurrenciesFetched = false
        CurrencyService.getCurrencyList { (answer) in
            switch answer {
            case .result(let currencyList as CurrencyList):
                self.currencyList = currencyList
            case .error(_ as DataTaskError):
                self.delegate?.createAlert(title: "Ocorreu um erro", message: "Verifique o status da sua conexão.", handler: nil)
                self.currencyList = nil
            case .error(let error as URLParsingError):
                self.delegate?.createAlert(title: "Erro \(error.code)", message: "Entre em contato com o administrador.", handler: nil)
                self.currencyList = nil
            default:
                self.delegate?.createAlert(title: "Erro genérico", message: "Entre em contato com o administrador.", handler: nil)
                self.currencyList = nil
            }
            self.isCurrenciesFetched = true
        }
    }
    
    private func getCachedQuotes() {
        
    }
    
    /**
     Convert currency from input text to an formatted new input and a converted output.
     
     - Parameter text: The text with the currency to be converted.
     */
    func convert(_ text: String?) -> ConvertResponse {
        if let inputText = text, !inputText.isEmpty {
            let originValue = prepareCurrencyInput(inputText)
                            
            // Text has a valid currency
            if let originValue = originValue,
               let valueConverted = convert(originValue, from: originCurrency, to: destinyCurrency) {
                
                currencyFormatter.currencyCode = originCurrency
                let input = currencyFormatter.string(from: originValue as NSNumber)
                
                currencyFormatter.currencyCode = destinyCurrency
                let output = currencyFormatter.string(from: valueConverted as NSNumber)
                return ConvertResponse(input: input ?? "", output: output ?? "")
            }
        }
        return ConvertResponse(input: "", output: "")
    }
    
    /**
     Convert the value from origin currency to destiny currency.
     
     - Parameter value: The amount to be converted.
     - Parameter origin: The currency of the amount.
     - Parameter destiny: The desired currency to convert for.
     */
    private func convert(_ value: Double, from origin: String, to destiny: String) -> Double? {
        let usdOriginKey = "USD" + origin
        let usdDestinyKey = "USD" + destiny
                
        guard let quotes = self.quotes,
              let originUSD = quotes.quotes[usdOriginKey],
              let destinyUSD = quotes.quotes[usdDestinyKey] else {
            return nil
        }
        
        // Converting from origin currency to USD then to destiny currency
        return (value / originUSD) * destinyUSD
    }
    
    /**
     Prepares the text to accept any currency removing non-digit characters expect for the separator.
     */
    private func prepareCurrencyInput(_ text: String) -> Double? {
        var inputText = text
        
        // Enable separator input
        currencyFormatter.alwaysShowsDecimalSeparator = inputText.last?.description == Locale.current.decimalSeparator ? true : false
        // Enable decimal character for 0 digit
        let splitString = inputText.split(separator: Character(Locale.current.decimalSeparator ?? ""))
        currencyFormatter.minimumFractionDigits = splitString.count > 1 && splitString[1].last?.description == "0" ? 1 : 0
        
        // Remove every non digit character except decimal separator
        inputText.removeAll(where: {Double($0.description) == nil && $0.description != Locale.current.decimalSeparator})
        inputText = inputText.replacingOccurrences(of: Locale.current.decimalSeparator ?? "", with: ".")
        
        return Double(inputText)
    }
    
    func setOrigin(for currency: Currency) {
        self.originCurrency = currency.symbol
    }
    
    func setDestiny(for currency: Currency) {
        self.destinyCurrency = currency.symbol
    }
    
    func isConvertEnabled() -> Bool {
        let isOriginValid = currencyList?.currencies.contains(where: {$0.symbol == originCurrency}) ?? false
        let isDestinyValid = currencyList?.currencies.contains(where: {$0.symbol == destinyCurrency}) ?? false
        let isValid = isOriginValid && isDestinyValid
        
        if !isValid {
            delegate?.createAlert(title: "Ops!", message: "Selecione a moeda de origem e destino.", handler: nil)
        }
        return isValid
    }
    
    private func dataLoaded() {
        // Finished loading data
        if isQuotesFetched && isCurrenciesFetched {
            delegate?.dataFetched()
        }        
    }
    
    func getCurrencyList() -> CurrencyList? {
        // Show an alert if there is no CurrencyList
        if currencyList == nil {
            delegate?.createAlert(title: "Ocorreu um erro", message: "Verifique o status da sua conexão e deslize para cima para tentar novamente.", handler: nil)
        }
        return currencyList
    }
    
    func getQuotes() -> CurrencyQuotes? {
        // Show an alert if there is no CurrencyList
        if quotes == nil {
            delegate?.createAlert(title: "Ocorreu um erro", message: "Verifique o status da sua conexão e deslize para cima para tentar novamente.", handler: nil)
        }
        return quotes
    }
}

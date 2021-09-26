//
//  ViewModel.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import Foundation

class ViewModel: ViewModelProtocol {
    
    // MARK: - CurrencyList properties
    
    weak var currencyListDelegate: CurrencyListViewModelDelegate?
    
    private var currencyListResponse: CurrencyList? {
        didSet {
            currencyList = currencyListResponse?.currencies.map {
                Currencie(initials: $0.key, name: $0.value)
            } ?? []
            currencyList = sortCurrencies()
        }
    }
    
    private(set) var currencyList: [Currencie]?
    
    // MARK: - Conversion properties
    
    weak var conversionDelegate: ConversionViewModelDelegate?
    
    var quotationLiveResponse: QuotationLive?
    
    var initialCurrency: String? {
        didSet {
            conversionDelegate?.initialCurrencyDidChange(currency: formatCurrencyName(currency: initialCurrency ?? "") ?? "")
            updateConvertedValue()
        }
    }
    
    var finalCurrency: String? {
        didSet {
            conversionDelegate?.finalCurrencyDidChange(currency: formatCurrencyName(currency: finalCurrency ?? "") ?? "")
            updateConvertedValue()
        }
    }
    
    var input: Float? {
        didSet {
            updateConvertedValue()
        }
    }
    
    var convertedValue: Float? {
        didSet {
            conversionDelegate?.convertedValueDidChange(value: convertedValue ?? 0)
        }
    }
    
    // MARK: - Shared properties
    
    var repository: Repository = RepositoryDefault()
    
    // MARK: - Private Methods
    
    private func updateConvertedValue() {
        convertedValue = convertCurrency()
    }
    
    private func convertCurrency() -> Float {
        guard let initialCurrency = initialCurrency,
              let finalCurrency = finalCurrency,
              let input = input
        else { return 0 }
        let initialCurrencyValue = getCurrencyValue(currency: initialCurrency)
        let dolars = input / initialCurrencyValue
        let finalCurrencyValue = getCurrencyValue(currency: finalCurrency)
        return finalCurrencyValue * dolars
    }
    
    private func getCurrencyValue(currency: String) -> Float {
        guard let currencyValue = quotationLiveResponse?.quotes[currency] else { return 0 }
        return currencyValue
    }
    
    private func fetchCurrencies(completion: @escaping (Result<Bool, RepositoryError>) -> Void) {
        repository.fetchCurrencyList { result in
            switch result {
            case .success(let currencyList):
                self.currencyListResponse = currencyList
                completion(.success(true))
            case .failure(let err):
                debugPrint(err.localizedDescription)
                completion(.failure(.networkError("Could not fetch currencies")))
            }
        }
    }
    
    func fetchQuotationLive() {
        repository.fetchQuotationLive { result in
            switch result {
            case .success(let quotationLive):
                self.quotationLiveResponse = quotationLive
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func sortCurrencies() -> [Currencie] {
        guard let currencyList = currencyList else { return [] }
        return currencyList.sorted {
            $0.name < $1.name
        }
    }
    
    // MARK: - Public Methods
        
    func onSelect(currency: String, isInitial: Bool) {
        if isInitial {
            initialCurrency = currency
        } else {
            finalCurrency = currency
        }
        currencyListDelegate?.didSelectCurrency()
    }
    
    func onValueChange(value: Float) {
        input = value
    }
    
    func getCurrencyName(index: Int) -> String? {
        guard let currency = currencyList?[index] else { return "" }
        return currency.name
    }
    
    func formatCurrencyName(currency: String) -> String? {
        let formatedCurrency = currencyList?.first(where: { result -> Bool in
            result.initials == currency.dropFirst(3)
        })?.name
        
        return formatedCurrency
    }
    
    func getCurrencyInitials(index: Int) -> String? {
        guard let currency = currencyList?[index] else { return "" }
        return currency.initials
    }
    
    func currenciesCount() -> Int? {
        guard let currencyList = currencyList else { return 0 }
        return currencyList.count
    }
    
    func onLoad() {
        fetchCurrencies { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.currencyListDelegate?.didFetchCurrencies()
                case .failure:
                    self.currencyListDelegate?.didFailToFetchCurrencies()
                }
            }
        }
        
        fetchQuotationLive()
        
    }
    
    func setCurrency(currency: String, isInitial: Bool) {
        if isInitial {
            initialCurrency = currency
        } else {
            finalCurrency = currency
        }
    }
}

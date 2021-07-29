//
//  HomeViewModel.swift
//  Coin Converter
//
//  Created by Igor Custodio on 27/07/21.
//

import Foundation

class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Variables
    var delegate: HomeViewDelegate?
    
    private var currencies: [Currency] = []
    private var quotes: [Quote] = []
    
    private var sourceCurrency: Currency?
    private var targetCurrency: Currency?
    private var valueToConvert: Double = 0.0
    private var convertedValue: Double = 0.0
    private var quotesLastUpdated = Date()
    private var service: ServiceProtocol
    
    // MARK: - Initializers
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Getters and setters methods
    func getCurrencies() -> [Currency] {
        return currencies
    }
    
    func setSelectedSourceCurrency(currency: Currency) {
        sourceCurrency = currency
    }
    
    func setSelectedTargetCurrency(currency: Currency) {
        targetCurrency = currency
    }
    
    // MARK: - Convert methods
    func convertCurrency(value: Double) {
        guard let source = sourceCurrency, let target = targetCurrency else { return }
        
        valueToConvert = value
        
        if source.initials == "USD" {
            let quote = getQuoteBy(currency: target)
            convertedValue = value * quote
        } else {
            let convertedToUSD = getQuoteBy(currency: source)
            let quote = getQuoteBy(currency: target)
            convertedValue = value * convertedToUSD / quote
        }
        
        delegate?.currencyConverted()
    }
    
    private func getQuoteBy(currency: Currency) -> Double {
        return quotes.filter{ $0.target == currency.initials }[0].quote
    }
    
    // MARK: - Text handlers
    
    func getConversionText() -> String {
        guard let source = sourceCurrency, let target = targetCurrency else {
            return ""
        }
        
        return "\(source.initials) \(valueToConvert) para \(target.initials):"
    }
    
    func getConvertedValueText() -> String {
        guard let target = targetCurrency else {
            return ""
        }
        
        return "\(target.initials) \(convertedValue.truncate(places: 2))"
    }
    
    func getLastUpdatedText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyy 'às' HH'h'mm"
        
        return "Última atualização em: \(dateFormatter.string(from: quotesLastUpdated))"
    }
}

// MARK: - Requests
extension HomeViewModel {
    func getList() {
        delegate?.showLoading()
        service.request(route: .list) { result in
            self.delegate?.currencyListLoaded()
            switch result {
                case .success(let data):
                    do {
                        let currencies = try JSONDecoder().decode(ListCurrenciesResponse.self, from: data)
                        self.currencies = currencies.toCurrency().sorted { $0.initials < $1.initials }
                    } catch {
                        self.delegate?.showAlertError(title: "Erro", message: "Não foi possível buscar a lista de moedas disponíveis")
                    }
                    break
                case .failure:
                    self.delegate?.showAlertError(title: "Erro", message: "Não foi possível buscar a lista de moedas disponíveis")
                    break
            }
        }
    }
    
    func getQuotesList() {
        service.request(route: .live) { result in
            self.delegate?.hideLoading()
            self.quotesLastUpdated = Date()
            self.delegate?.quotesListLoaded()
            switch result {
                case .success(let data):
                    do {
                        let quotesList = try JSONDecoder().decode(ListQuotesResponse.self, from: data)
                        self.quotes = quotesList.toQuote()
                    } catch {
                        self.delegate?.showAlertError(title: "Erro", message: "Não foi possível buscar a cotação atualizada")
                    }
                    break
                case .failure:
                    self.delegate?.showAlertError(title: "Erro", message: "Não foi possível buscar a cotação atualizada")
                    break
            }
        }
    }
}

//
//  CurrencyQuoteService.swift
//  iOS Giovane Barreira
//
//  Created by Giovane Barreira on 10/2/20.
//

import Foundation

protocol CurrencyQuoteServiceProtocol {
    typealias fetchAllCurrenciesSuccess = ((QuotesModel) -> Void)
    typealias fetchFailure = ((Error) -> Void)
    
    func fetchCurrencies(success: @escaping fetchAllCurrenciesSuccess,
                         failure: @escaping fetchFailure)
}

class CurrencyQuoteService: CurrencyQuoteServiceProtocol {
    
    /// MARK: - Proprerties
    private var decoder = JSONDecoder()
    private let quotesListRequest: QuotesRequestURL
    
    /// MARK: - Constructor
    init(quotesListRequest: QuotesRequestURL) {
        self.quotesListRequest = quotesListRequest
    }
    
    func fetchCurrencies(success: @escaping fetchAllCurrenciesSuccess,
                         failure: @escaping fetchFailure) {
      
        guard let url = URL(string: quotesListRequest.endpoint) else { return }
    
        URLSession.shared.dataTask(with:url) { (data, response, error) in
            do {
                 
                guard let data = data else { return }
                let json = try self.decoder.decode(QuotesModel.self, from: data)
                success(json)

            } catch {
                failure(error)
            }
        }.resume()
    }
    
}

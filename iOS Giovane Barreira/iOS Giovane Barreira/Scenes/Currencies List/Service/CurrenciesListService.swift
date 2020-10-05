//
//  CurrenciesListService.swift
//  iOS Giovane Barreira
//
//  Created by Giovane Barreira on 10/4/20.
//

import Foundation

protocol CurrenciesListServiceProtocol {
    typealias fetchListCurrenciesSuccess = ((CurrenciesListModel) -> Void)
    typealias fetchFailure = ((Error) -> Void)
    
    func fetchList(success: @escaping fetchListCurrenciesSuccess,
                         failure: @escaping fetchFailure)
}

class CurrenciesListService: CurrenciesListServiceProtocol {
    
    /// MARK: - Proprerties
    private var decoder = JSONDecoder()
    private let currenciesListURL: CurrenciesListRequestURL
    
    /// MARK: - Constructor
    init(currenciesListURL: CurrenciesListRequestURL) {
        self.currenciesListURL = currenciesListURL
    }
    
    func fetchList(success: @escaping fetchListCurrenciesSuccess,
                         failure: @escaping fetchFailure) {
      
        guard let url = URL(string: currenciesListURL.endpoint) else { return }
    
        URLSession.shared.dataTask(with:url) { (data, response, error) in
            do {
                 
                guard let data = data else { return }
                let json = try self.decoder.decode(CurrenciesListModel.self, from: data)
                success(json)

            } catch {
                failure(error)
            }
        }.resume()
    }
    
}

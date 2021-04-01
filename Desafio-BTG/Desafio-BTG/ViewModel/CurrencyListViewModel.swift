//
//  CurrencyListViewModel.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 01/04/21.
//

import Foundation

final class CurrencyListViewModel {
    
    private let api: CurrencyListModelProtocol
    private var model: CurrencyListModel?
    
    init(api: CurrencyListModelProtocol = RequestApi()) {
        self.api = api
    }
    
    var modelDetails: CurrencyListModel? {
        return model
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

}

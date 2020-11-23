//
//  CurrencyListViewModel.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

/// Method to prepare Currency data to be shown in the view
class CurrencyListViewModel {

    //Properties
    private let networkManager = NetworkManager()
    var currencies = [CurrencyModel]()
    
    var currenciesByName: [CurrencyModel] {
        return currencies.sorted { $0.name < $1.name }
    }
    
    var currenciesByCode: [CurrencyModel] {
        return currencies.sorted { $0.code < $1.code }
    }
    
    /// Method to fetch Data from API
    /// - Parameter completion: completion indicating if operation is finished and if it is successful
    func fetchCurrencies(completion: @escaping ([Error]?) -> Void ) {
        var listModel: ListModel?
        var liveModel: LiveModel?
        var errors = [NetworkError]()
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        networkManager.request(model: ListModel.self) { (result) in
            switch result {
            case .success(let listModelData):
                listModel = listModelData
            case .failure(let error):
                errors.append(error)
                print(error)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkManager.request(model: LiveModel.self) { (result) in
            switch result {
            case .success(let liveModelData):
                liveModel = liveModelData
            case .failure(let error):
                errors.append(error)
                print(error)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.buildCurrencyModel(list: listModel, live: liveModel)
            completion(errors)
        }
    }
    
    /// Method to make data from API fit into CurrencyModel
    /// - Parameters:
    ///   - list: Struct fetched from API list call
    ///   - live:  Struct fetched from API live call
    private func buildCurrencyModel(list: ListModel?, live: LiveModel?) {
        guard let currencyNames = list?.currencies else { return }
        guard let currencyValues = live?.quotes else { return }
        
        for (key, value) in currencyNames {
            guard let exchangeValue = currencyValues["USD\(key)"] else { return }
            currencies.append(CurrencyModel(code: key, name: value, value: exchangeValue))
        }
    }
}

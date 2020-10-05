//
//  CurrenciesListViewModel.swift
//  iOS Giovane Barreira
//
//  Created by Giovane Barreira on 10/4/20.
//

import Foundation

protocol CurrenciesListViewModelOutputProtocol: class {
    func getList(listModel: CurrenciesListModel)
}

class CurrenciesListViewModel {
    
    /// MARK: - Properties
    var service: CurrenciesListService
    weak var currenciesListViewModelProtocolDelegate: CurrenciesListViewModelOutputProtocol?
    var currenciesListRequestURL: CurrenciesListRequestURL
    
    init() {
        self.currenciesListRequestURL = CurrenciesListRequestURL()
        self.service = CurrenciesListService(currenciesListURL: currenciesListRequestURL)
    }
    
    func fetchList () {
        service.fetchList { [weak self] (model) in
            self?.currenciesListViewModelProtocolDelegate?.getList(listModel: model)
        } failure: { [weak self] (error) in
            print(error.localizedDescription)
        }
    }
    
}

struct CurrenciesListBind {
    private let currenciesList: CurrenciesListModel
    private var sortDictionary: [Dictionary<String, String>.Element]?
    
    init(_ currenciesList: CurrenciesListModel) {
        self.currenciesList = currenciesList
        sortDictionary = currenciesList.currencies?.sorted { $0.0 < $1.0 } .map { $0 }
        sortDictionary = self.sortDictionary.map({$0})
    }
    
    var title: [String]? {
        let getKeys = sortDictionary?.map({$0.key})
        return getKeys
    }
    
    var description: [String]? {
        let getValues = sortDictionary?.map({$0.value})
        return getValues
    }
}

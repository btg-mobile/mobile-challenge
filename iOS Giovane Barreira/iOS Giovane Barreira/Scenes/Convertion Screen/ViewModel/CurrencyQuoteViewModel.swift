//
//  CurrencyQuoteViewModel.swift
//  iOS Giovane Barreira
//
//  Created by Giovane Barreira on 10/3/20.
//

import Foundation

protocol ViewModelOutputProtocol: class {
    func getQuotes(currencyModel: QuotesModel)
}

class CurrencyQuoteViewModel {
    
    /// MARK: - Properties
    var service: CurrencyQuoteService
    weak var viewModelOutputDelegate: ViewModelOutputProtocol?
    var quotesListRequestURL: QuotesRequestURL

    init() {
        self.quotesListRequestURL = QuotesRequestURL()
        self.service = CurrencyQuoteService(quotesListRequest: quotesListRequestURL)
    }
    
   func fetchQuotes () {
        service.fetchCurrencies  { [weak self] (model) in
            self?.viewModelOutputDelegate?.getQuotes(currencyModel: model)
        } failure: { [weak self] (error) in
            print(error.localizedDescription)
        }
   }
}

struct QuotesListBind {
    private let quotesListModel: QuotesModel
    private var sortDictionary: [Dictionary<String, Double>.Element]?

    init(_ quotesListModel: QuotesModel) {
        self.quotesListModel = quotesListModel
        sortDictionary = quotesListModel.allCurrencies?.sorted { $0.0 < $1.0 } .map { $0 }
        sortDictionary = self.sortDictionary.map{$0}
    }
    
    var code: [String]? {
        let getKeys = sortDictionary?.map({$0.key})
        return getKeys
    }
    
    var value: [Double]? {
        let getValues = sortDictionary?.map({$0.value})
        return getValues
    }
}



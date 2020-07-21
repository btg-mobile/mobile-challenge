//
//  ListCurrenciesViewModel.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 19/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

// MARK: - SortType
enum SortType {
    case name
    case code
}

// MARK: - ListCurrenciesViewModelDelegate
protocol ListCurrenciesViewModelDelegate: class {
    func didStartLoading()
    func didHideLoading()
    func didReloadData()
    func didFail()
}

// MARK: - Main
class ListCurrenciesViewModel {
    weak var delegate: ListCurrenciesViewModelDelegate?
    
    private var service: ListCurrenciesService?
    private var conversion: Conversion?
    private(set) var listCurrencies: [ListCurrenciesModel]?
    private(set) var isSort = Bool()
    
    private var currencies: [ListCurrenciesModel]?
    
    init(service: ListCurrenciesService, conversion: Conversion) {
        self.service = service
        self.conversion = conversion
    }
}

// MARK: - PublicMethods
extension ListCurrenciesViewModel {
    func fetchListCurrencies() {
        delegate?.didStartLoading()
        isSort = false
        
        service?.fetchListCurrencies(success: { listCurrencies in
            self.delegate?.didHideLoading()
            
            self.currencies = self.handleListCurrencies(
                with: listCurrencies
            )
            
            self.listCurrencies = self.handleListCurrencies(
                with: listCurrencies
            )
            self.delegate?.didReloadData()
        }, fail: { serviceError in
            print(serviceError)
        })
    }
    
    func searchListCurrencies(whit text: String) {
        if text.count > 0 {
            var list = self.listCurrencies
            list = list?.filter {
                $0.name.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(
                    text.lowercased().folding(options: .diacriticInsensitive, locale: .current)
                    ) ||
                    $0.code.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(
                        text.lowercased().folding(options: .diacriticInsensitive, locale: .current)
                )
            }
            listCurrencies = list
            delegate?.didReloadData()
            return
        }
        
        listCurrencies = currencies
        isSort = false
        delegate?.didReloadData()
    }
    
    func sortBy(_ sortType: SortType, with list: [ListCurrenciesModel]) {
        switch sortType {
        case .code:
            self.listCurrencies = list.sorted {
                $0.code < $1.code
            }
        case .name:
            self.listCurrencies = list.sorted {
                $0.name < $1.name
            }
        }
        
        isSort = true
        delegate?.didReloadData()
    }
}

// MARK: - PrivateMethods
extension ListCurrenciesViewModel {
    private func handleListCurrencies(with listCurrencies: ListCurrencies) -> [ListCurrenciesModel] {
        var list = listCurrencies.currencies.map({ (key, value) -> ListCurrenciesModel in
            return ListCurrenciesModel(name: value, code: key)
        })
        list = list.sorted {
            $0.name < $1.name
        }
        
        return list
    }
}

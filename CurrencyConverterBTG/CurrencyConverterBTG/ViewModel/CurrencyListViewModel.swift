//
//  CurrencyListViewModel.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 23/03/21.
//

import UIKit

class CurrencyListViewModel {
    
    private var currencies = [Currency]() {
        didSet {
            filterCurrencies(search: searchString)
        }
    }
    
    private var searchString = ""
    
    var filteredCurrencies = [Currency]() {
        didSet {
            viewController?.update()
        }
    }
    
    var rowsInSection: Int {
        return filteredCurrencies.count ?? 0
    }
    
    weak var viewController: CurrencyListViewController?
    
    init() {
        CurrencyLayerAPI.shared.fetchSupportedCurrencies { [unowned self] result in
            switch result {
            case .success(let currenciesDTO):
                self.currencies = currenciesDTO.currencies.sorted(by: { (c1, c2) -> Bool in
                    c1.code < c2.code
                })
            case .failure(let error):
                switch error {
                case NetworkingError.transportError:
                    Debugger.log("There was a problem on your internet connection")
                default:
                    Debugger.log(error.rawValue)
                }
            }
        }
    }
    
    func filterCurrencies(search: String?) {
        guard let search = search else { return }
        if search == "" {
            filteredCurrencies = currencies
        } else {
            let filtered = currencies.filter({ (currency) -> Bool in
                currency.name.contains(search) || currency.code.contains(search.uppercased())
            })
            filteredCurrencies = filtered
        }
        searchString = search
    }
}

//
//  CurrencyListViewModel.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 23/03/21.
//

import UIKit

class CurrencyListViewModel {
    
    var currencies: [Currency]? {
        didSet {
            viewController?.update()
        }
    }
    
    var rowsInSection: Int {
        return currencies?.count ?? 0
    }
    
    weak var viewController: CurrencyListViewController?
    
    init() {
        CurrencyLayerAPI.shared.fetchSupportedCurrencies { [unowned self] currencies in
            if let currencies = currencies {
                self.currencies = currencies
            }
        }
    }
}

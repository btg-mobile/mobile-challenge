//
//  CurrencySearchBarDelegate.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 30/10/20.
//

import UIKit

class CurrencySearchBarDelegate: NSObject, UISearchBarDelegate {
    
    
    var currencies: [Currency]
    var reloadToApplyFilter: (() -> Void)?
    
    init(currencies: [Currency]) {
        self.currencies = currencies
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let scopeString = searchBar.scopeButtonTitles?[selectedScope] else { return }
        
        let currencyFilterSearchBar = CurrencyFilterSearchBar(rawValue: scopeString)
        
        switch currencyFilterSearchBar {
        
        case .nome:
            self.currencies = currencies.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .codigo:
            self.currencies = currencies.sorted { $0.code.lowercased() < $1.code.lowercased() }
        default:
            break
            
        }
        
        reloadToApplyFilter?()
    }
    
    
}

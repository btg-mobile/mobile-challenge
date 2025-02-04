//
//  TableViewCurrencyDelegate.swift
//  MobileChallenge
//
//  Created by Gabriel Vicentin Negro on 20/11/24.
//

import Foundation
import UIKit

class TableViewCurrencyDelegate: NSObject, UITableViewDelegate {

    weak var viewController: CurrencyListingViewController?
    weak var liveValueViewModel: LiveValueViewModel?
    weak var listOfCurrencyViewmodel: ListOfCurrencyViewModel?
    
    init(viewController: CurrencyListingViewController? = nil, liveValueViewModel: LiveValueViewModel? = nil, listOfCurrencyViewmodel: ListOfCurrencyViewModel? = nil) {
        self.viewController = viewController
        self.liveValueViewModel = liveValueViewModel
        self.listOfCurrencyViewmodel = listOfCurrencyViewmodel
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = viewController else { return }
        guard let liveValueViewModel = liveValueViewModel else { return }
        guard let listOfCurrencyViewModel = listOfCurrencyViewmodel else { return }
        
        var listOfCurrencyCodes: [String] = []
        
        if listOfCurrencyViewModel.filteredCurrencies.isEmpty {
            let sortedListOfCurrency = listOfCurrencyViewModel.currencies.sorted { $0.key < $1.key }
            listOfCurrencyCodes = sortedListOfCurrency.map { $0.key }
        } else {
            listOfCurrencyCodes = listOfCurrencyViewModel.filteredCurrencies.map { $0.key }
        }
        
        
        if viewController.fromOrTo == .from {
            liveValueViewModel.updateSelectedCurrencyFrom(selectedFromCurrency: listOfCurrencyCodes[indexPath.row])
        }
        else {
            liveValueViewModel.updateSelectedCurrencyTo(selectedToCurrency: listOfCurrencyCodes[indexPath.row])
        }
        viewController.dismiss(animated: true)
    }
}

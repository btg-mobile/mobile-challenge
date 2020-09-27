//
//  CurrenciesDelegate.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import UIKit

enum ButtonTapped {
    case source, destiny
}

class CurrenciesDelegate: NSObject, UITableViewDelegate {
    let viewModel: CurrencyListViewModel
    let converterViewModel: ConverterViewModel
    let buttonTapped: ButtonTapped
    
    init(viewModel: CurrencyListViewModel, converterViewModel: ConverterViewModel, buttonTapped: ButtonTapped) {
        self.viewModel = viewModel
        self.converterViewModel = converterViewModel
        self.buttonTapped = buttonTapped
        super.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.currencies.count > 0 else { return }
        let currency = viewModel.currencies[indexPath.row]
        let USD = Identifier.Currency.USD.rawValue
        
        if buttonTapped == .source {
            converterViewModel.source = currency
            if currency.code != USD {
                converterViewModel.dollar = getDollar()
            }
        }
        else if buttonTapped == .destiny {
            converterViewModel.destiny = currency
        }
    }
    
    private func getDollar() -> CurrencyModel? {
        let USD = Identifier.Currency.USD.rawValue
        guard let index = viewModel.currencies.firstIndex(where: { $0.code == USD }) else { return nil }
        return viewModel.currencies[index]
    }
}

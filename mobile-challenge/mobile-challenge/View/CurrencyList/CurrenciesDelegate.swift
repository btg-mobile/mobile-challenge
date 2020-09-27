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
        
        if buttonTapped == .source {
            converterViewModel.source = currency
        }
        else if buttonTapped == .destiny {
            converterViewModel.destiny = currency
        }
    }
}

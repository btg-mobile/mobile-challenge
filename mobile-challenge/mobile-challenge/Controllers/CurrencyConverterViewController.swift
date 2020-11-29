//
//  CurrencyConverterViewController.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    // View Model
    let currencyConverter = CurrencyConverterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        currencyConverter.getQuotes()
    }
    
    private func setupBindings() {
        currencyConverter.quotesFetched = {
            self.updateData()
        }
    }
    
    private func updateData() {
        print(currencyConverter.quotes)
    }

}

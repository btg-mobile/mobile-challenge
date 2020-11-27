//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    var quotationView: CurrencyListView {
        return view as! CurrencyListView
    }
    weak var coordinator: CurrencyListCoordinator?
    
    override func loadView() {
        super.loadView()
        view = CurrencyListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension CurrencyListViewController: CurrencyListDelegate {
    func showCurrencyList(currenciesQuotation: [CurrencyQuotation]) {
        
    }
    
    func showError(error: Error) {
        
    }
}

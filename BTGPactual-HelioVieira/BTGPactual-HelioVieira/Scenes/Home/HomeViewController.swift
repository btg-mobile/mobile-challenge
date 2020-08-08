//
//  HomeViewController.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 07/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    let viewModel = HomeViewModel()
    
    // MARK: Outlets
    @IBOutlet weak var edtInputValue: UITextField!
    @IBOutlet weak var lblOutputValue: UILabel!
    @IBOutlet weak var lblInputCurrencyCode: UILabel!
    @IBOutlet weak var lblInputCurrencyName: UILabel!
    @IBOutlet weak var lblOutputCurrencyCode: UILabel!
    @IBOutlet weak var lblOutputCurrencyName: UILabel!
    @IBOutlet weak var lblEquatableCurrencys: UILabel!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindEvents()
        viewModel.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showLoading()
    }
    
    // MARK: Actions
    @IBAction func handlerCurrencyInput(_ sender: Any) {
    }
    
    @IBAction func handlerCurrencyOutput(_ sender: Any) {
    }
    
    // MARK: Helpers
    private func bindEvents() {
        viewModel.didSuccess = { [weak self] in
            self?.closeLoading()
            
            //continua...
        }
        
        viewModel.didFailure = { [weak self] error in
            self?.closeLoading()
            print("==> Error: \(error)")
        }
    }
}

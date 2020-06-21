//
//  ConversionViewController.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 18/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {

    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func selectFromCurrancy(_ sender: UIButton) {
        coordinator?.selectCurrency()
    }
    
    
    @IBAction func selectToCurrency(_ sender: UIButton) {
        coordinator?.selectCurrency()
    }
    
    @IBAction func convertButton(_ sender: UIButton) {
        CurrencyLayerRepository.sharedInstance().getLiveQuotes{ (response, erro) in
            print("First quote: \(response?.quotes.first?.quote)")
            print("Response: \(String(describing: response))")
            print("Erro: \(String(describing: erro))")
        }
    }
}

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

        // Do any additional setup after loading the view.
    }


    @IBAction func selectFromCurrancy(_ sender: UIButton) {
        coordinator?.selectCurrency()
    }
    
    
    @IBAction func selectToCurrency(_ sender: UIButton) {
        coordinator?.selectCurrency()
    }
}

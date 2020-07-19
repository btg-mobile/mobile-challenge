//
//  ViewController.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let listCurrenciesService = ListCurrenciesService()
    let currenciesConversionService = CurrenciesConversionService()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        listCurrenciesService.fetchListCurrencies(success: { listCurrencies in
            print(listCurrencies)
        }) { serviceError in
            print(serviceError)
        }
        
        currenciesConversionService.fetchQuotes(success: { currenciesConversion in
            print(currenciesConversion)
        }) { serviceError in
            print(serviceError)
        }
    }
}

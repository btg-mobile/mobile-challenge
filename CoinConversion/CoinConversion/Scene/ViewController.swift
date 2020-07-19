//
//  ViewController.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let service = ListCurrenciesService()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        service.fetchListCurrencies(success: { listCurrencies in
            print(listCurrencies ?? "errrrrooorrrrrr")
        }) { serviceError in
            print(serviceError)
        }
    }
}

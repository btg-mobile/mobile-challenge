//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Alan Silva on 10/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.teste()

    }
    
    func teste(){
  
        let provider = CurrencyDataProvider(from: "BRL", to: "BTN")

        provider.getListOfCurrencies { [weak self] results in
            
            switch results {
            case .success(let dict):
                print(dict)
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
}


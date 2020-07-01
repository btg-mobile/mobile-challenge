//
//  ViewController.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 30/06/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       CurrencyManager().fetchList { (result) in
            switch result {
            case .success(let dados):
                dump(dados)
            case .failure(let error):
                dump(error)
            }
        }
        
    }
    
    
}


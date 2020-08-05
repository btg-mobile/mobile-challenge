//
//  ExchangeViewController.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    let localCurrency: Currency
    let foreignCurrency: Currency
    
    init(localCurrency: Currency, foreignCurrency: Currency) {
        self.localCurrency = localCurrency
        self.foreignCurrency = foreignCurrency
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("🔥")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

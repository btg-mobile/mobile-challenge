//
//  CurrenciesViewController.swift
//  Screens
//
//  Created by Gustavo Amaral on 30/04/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

class CurrenciesViewController: UINavigationController, Drawable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    init() {
        let tableViewController = CurrenciesTableViewController()
        super.init(rootViewController: tableViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


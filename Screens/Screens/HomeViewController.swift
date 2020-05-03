//
//  HomeViewController.swift
//  Screens
//
//  Created by Gustavo Amaral on 29/04/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    override func loadView() { view = homeView }
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.draw()
        
        let currency = HomeView.Model.OtherCurrency(amount: "0.92", currenciesPair: "USD to EUR", lastSeen: "12:54")
        homeView.otherCurrencies = Array(repeating: currency, count: 60)
    }
}

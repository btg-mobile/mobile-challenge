//
//  CurrencyConversionViewController.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import UIKit

class CurrencyConversionViewController: UIViewController {
    // MARK: UI Components
    
    let containerView = UIView()
    let firstCurrencyLabelDescription = UILabel()
    let firstCurrencyTextFieldSelector = UITextField()
    let equalSignalImage = UIImageView()
    let secondCurrencyLabelDescription = UILabel()
    let secondCurrencyTextFieldSelector = UITextField()
    
    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
        self.bindUI()
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        setupNavigation()
        setupBackground()
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 251/255,
                                                                           green: 160/255,
                                                                           blue: 40/255,
                                                                           alpha: 1.0)
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "navigationImage"))
    }
    
    func setupBackground() {
        self.view.backgroundColor = UIColor(red: 252/255,
                                            green: 227/255,
                                            blue: 116/255,
                                            alpha: 1.0)
    }
    
    // MARK: - Bind UI
    
    func bindUI() {
        
    }
}

//
//  ConversionViewController.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

// MARK: - Main
class ConversionViewController: UIViewController {
    
    var viewModel: ConversionViewModel?
    
    init(viewModel: ConversionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ConversionViewController.nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.delegate = self
        viewModel?.fetchQuotes()
    }
}

// MARK: - ConversionViewModelDelegate
extension ConversionViewController: ConversionViewModelDelegate {
    
}

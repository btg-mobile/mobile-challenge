//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 01/12/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    // MARK: - Properties
    private lazy var baseView = CurrencyConverterView()
    weak var coordinator: MainCoordinator?
    
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        self.view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
}


// MARK: - Setup Navigation Bar
extension CurrencyConverterViewController {
    private func setupNavigationBar() {
        navigationItem.title = "Currency Converter"
    }
}

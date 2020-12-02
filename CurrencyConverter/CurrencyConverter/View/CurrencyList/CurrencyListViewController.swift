//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import UIKit

class CurrencyListViewController: UIViewController {
    // MARK: - Properties
    private lazy var viewModel = CurrencyListViewModel()
    
    weak var coordinator: MainCoordinator?
    
    // MARK: - Initialization
    override func loadView() {
        super.loadView()
        self.view = UIView()
        self.view.backgroundColor = .blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View Model
        viewModel.delegate = self
        viewModel.fetchCurrencies()
    }
}


// MARK: - CurrencyListViewModelDelegate
extension CurrencyListViewController: CurrencyListViewModelDelegate {
    func didReceiveCurrencies() {
        print("Chegou moedas")
        print(viewModel.currencies.count)
    }
    
    func didReceiveError(error: Error) {
        guard let detectedError = error as? NetworkError else {
            return
        }
        
        print(detectedError.localizedDescription)
    }
}


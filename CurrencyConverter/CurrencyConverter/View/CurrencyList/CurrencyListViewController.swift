//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import UIKit

class CurrencyListViewController: UIViewController {
    // MARK: - Properties
    private lazy var baseView = CurrencyListView()
    private lazy var viewModel = CurrencyListViewModel()
    
    weak var coordinator: MainCoordinator?
    
    private var dataSource: CurrencyListDataSource? {
        didSet {
            guard let validDataSource = dataSource else {
                return
            }
            
            validDataSource.didSelectCurrency = { [weak self] selectedCurrency in
                self?.didSelectCurrency(selectedCurrency: selectedCurrency)
            }
            
            // Update Table View
            DispatchQueue.main.async { [weak self] in
                self?.baseView.tableView.dataSource = validDataSource
                self?.baseView.tableView.delegate = validDataSource
                self?.baseView.tableView.reloadData()
            }
        }
    }
    
    
    
    
    // MARK: - Initialization
    override func loadView() {
        super.loadView()
        self.view = baseView
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
        self.dataSource = CurrencyListDataSource(currencies: viewModel.currencies)
    }
    
    func didReceiveError(error: Error) {
        guard let detectedError = error as? NetworkError else {
            return
        }
        
        print(detectedError.localizedDescription)
    }
}


// MARK: - Handle Selected Currency
extension CurrencyListViewController {
    private func didSelectCurrency(selectedCurrency: Currency) {
        print("Selected currency:", selectedCurrency)
    }
}


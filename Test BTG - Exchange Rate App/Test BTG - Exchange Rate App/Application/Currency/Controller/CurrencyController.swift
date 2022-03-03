//
//  CurrencyController.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 25/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import UIKit

protocol CurrencyControllerProtocol {
    func selectCurrency(_ currency: CurrencyModel?)
}

class CurrencyController: UIViewController {
    
    // MARK: - Properties
    
    private let currencyTableView = { return UITableView() }()
    
    
    private lazy var viewModel = { return CurrencyViewModel() }()
    
    public var currencyList:    [CurrencyModel]?
    public var delegate:        CurrencyControllerProtocol?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupDataSource()

        setupBindables()

        applyViewCode()
    }
    
    // MARK: - Methods
    
    private func setupDelegate() {
        currencyTableView.delegate = self
    }
    
    private func setupDataSource() {
        currencyTableView.dataSource = self
    }
    
    func setupBindables() {
        viewModel.isUpdateTable.bind { [unowned self] (isUpdate) in
            guard let update = isUpdate, update else {
                return
            }
            self.currencyTableView.reloadData()
        }
    }
    
}

// MARK: - ViewCodeConfiguration

extension CurrencyController: ViewCodeConfiguration {
    public func configureViews() {
        viewModel.setList(currencyList)
        
        currencyTableView.register(CurrencyTableViewCell.self,
                                   forCellReuseIdentifier: CurrencyTableViewCell.identifier)
    }
    
    public func buildHierarchy() {
        view.addSubview(currencyTableView)
    }
    
    public func setupConstraints() {
        currencyTableView.frame = view.bounds
    }
}

// MARK: - UITableViewDelegate

extension CurrencyController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let currency = viewModel.listCurrencies.value?[indexPath.row] else {
            print("DEBUG: Currency at indexPath is empty.")
            return
        }
        print(currency.code)
        
        guard let delegate = self.delegate else {
            print("DEBUG: Missing CurrencyControllerProtocol delegate.")
            return
        }
        delegate.selectCurrency(currency)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
}

// MARK: - UITableViewDataSource

extension CurrencyController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listCurrencies.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as! CurrencyTableViewCell
        
        guard let currency = viewModel.listCurrencies.value?[indexPath.row] else { return cell }
        cell.setCurrency(currency)
                
        return cell
    }
    
    
}

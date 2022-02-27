//
//  CurrencyController.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 25/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import UIKit

class CurrencyController: UIViewController {
    
    // MARK: - Properties
    
    private let currencyTableView = { return UITableView() }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupDataSource()

        applyViewCode()
    }
    
    // MARK: - Methods
    
    private func setupDelegate() {
        currencyTableView.delegate = self
    }
    
    private func setupDataSource() {
        currencyTableView.dataSource = self
    }
    
}

// MARK: - ViewCodeConfiguration

extension CurrencyController: ViewCodeConfiguration {
    public func configureViews() {
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
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

// MARK: - UITableViewDataSource

extension CurrencyController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as! CurrencyTableViewCell
        
        cell.setCurrencyCode("USD")
        cell.setCurrencyName("United States Dollar")
                
        return cell
    }
    
    
}

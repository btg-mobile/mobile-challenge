//
//  CurrencyListView.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 01/04/21.
//

import UIKit

protocol DismissScreen {
    func dismissScreenTapped()
}

class CurrencyListView: UIView {
    
    // MARK: - Properties
    
    var delegate: DismissScreen?
    var viewModel: CurrencyViewModel?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    // MARK: - Override & Initializers
    
    convenience init(viewModel: CurrencyViewModel?) {
        self.init()
        self.viewModel = viewModel
        setupViewHierarchy()
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyListCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.backgroundColor = .clear
    }
    
    // MARK: - Private functions
    
    private func setupViewHierarchy() {
        self.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 24).isActive = true
    }
}

// MARK: - Extensions

extension CurrencyListView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.setContentCurrencies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyListCell
        cell.setup(viewModel?.setContentCurrencies[indexPath.row].key ?? "", viewModel?.setContentCurrencies[indexPath.row].value ?? "")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyArray = viewModel?.setContentCurrencies[indexPath.row].key
        if SelectedCurrencySingleton.selectedCurrency == selectedCurrency.ofCurrency {
            viewModel?.gettingCountryOne(countryOne: keyArray ?? "")
        } else {
            viewModel?.gettingCountryTwo(countryTwo: keyArray ?? "")
        }
        delegate?.dismissScreenTapped()
    }
}

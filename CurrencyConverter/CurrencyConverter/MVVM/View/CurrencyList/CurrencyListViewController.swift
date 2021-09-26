//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu on 25/09/21.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        setupView()
        indicatorView.startAnimating()
        viewModel?.onLoad()
    }
    
    var viewModel: CurrencyListViewModel?
    var isInitial: Bool = true
    
    let cellIdentifer = "cell"
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator =  UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        tableView.register(CurrencyListTableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        return tableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Moedas"
    }
    
    func tapCurrency() {
        viewModel?.onSelect(currency: "asas", isInitial: isInitial)
    }
}

extension CurrencyListViewController: CurrencyListViewModelDelegate {
    func didSelectCurrency() {
        navigationController?.popViewController(animated: true)
    }
    
    func didFetchCurrencies() {
        indicatorView.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func didFailToFetchCurrencies() {
        print("fail to fetch currencies")
    }
}

extension CurrencyListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.currenciesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as? CurrencyListTableViewCell,
              let currencyName = viewModel?.getCurrencyName(index: indexPath.row),
              let currencyInitials = viewModel?.getCurrencyInitials(index: indexPath.row)
        else { return UITableViewCell() }
    
        cell.setupCell(currencieName: currencyInitials + " - " + currencyName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.setCurrency(currency: "USD" + (viewModel?.getCurrencyInitials(index: indexPath.row) ?? ""), isInitial: isInitial)
        didSelectCurrency()
    }
}

extension CurrencyListViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(indicatorView)
    }
    
    func setupConstraints() {
        tableView.anchorTo(superview: view)
        indicatorView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func additionalConfigurations() {
        setupNavigationBar()
        view.backgroundColor = .white
    }
}

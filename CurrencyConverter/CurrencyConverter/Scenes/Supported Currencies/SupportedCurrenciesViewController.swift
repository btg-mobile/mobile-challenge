//
//  SupportedCurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 12/02/20.
//  Copyright (c) 2020 Tiago Chaves. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SelectCurrencyDelegate: class {
    func setCurrency(_ currency: Currency, to: CurrencyType)
}

protocol SupportedCurrenciesDisplayLogic: class {
    func displaySupportedCurrenciesList(viewModel: SupportedCurrenciesVIPModels.LoadSupportedCurrencies.ViewModel)
}

class SupportedCurrenciesViewController: UIViewController, SupportedCurrenciesDisplayLogic {
    var interactor: SupportedCurrenciesBusinessLogic?
    var router: (NSObjectProtocol & SupportedCurrenciesRoutingLogic & SupportedCurrenciesDataPassing)?
    
    // MARK: Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = SupportedCurrenciesInteractor()
        let presenter = SupportedCurrenciesPresenter()
        let router = SupportedCurrenciesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
        router.viewController = viewController
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields(textFields: [searchBar.searchTextField])
        loadSupportedCurrenciesList()
    }
    
    //MARK: - Vars and IBOutlets
    weak var delegate: SelectCurrencyDelegate?
    var currencies: [Currency] = [] {
        didSet {
            reloadTableContent()
        }
    }
    var filteredCurrencies: [Currency] = [] {
        didSet {
            reloadTableContent()
        }
    }
    var filtering: Bool = false
    var currencyType: CurrencyType = .source
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private func reloadTableContent() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Load supported currencies list
    private func loadSupportedCurrenciesList() {
        interactor?.loadSupportedCurrencies(request: SupportedCurrenciesVIPModels.LoadSupportedCurrencies.Request())
    }
    
    func displaySupportedCurrenciesList(viewModel: SupportedCurrenciesVIPModels.LoadSupportedCurrencies.ViewModel) {
        if !filtering {
            self.currencies = viewModel.currencies
        } else {
            self.filteredCurrencies = viewModel.currencies
        }
        self.currencyType = viewModel.currencyType
    }
}

extension SupportedCurrenciesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtering ? filteredCurrencies.count : currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "currencyCell"
        let currency = filtering ? filteredCurrencies[indexPath.row] : currencies[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell.textLabel?.text = "\(currency.name) (\(currency.initials))"
            return cell
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = "\(currency.name) (\(currency.initials))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = self.delegate {
            let currency = filtering ? filteredCurrencies[indexPath.row] : currencies[indexPath.row]
            delegate.setCurrency(currency, to: self.currencyType)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension SupportedCurrenciesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

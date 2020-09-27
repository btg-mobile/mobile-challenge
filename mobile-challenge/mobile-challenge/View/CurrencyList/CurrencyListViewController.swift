//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 25/09/20.
//

import UIKit

class CurrencyListViewController: UIViewController, Storyboarded {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var orderButtonType: OrderButtonTitle = .code
    lazy var orderBarItem: UIBarButtonItem = createOrderButton(orderButtonType)
    
    lazy var viewModel: CurrencyListViewModel = {
        let viewModel = CurrencyListViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    var converterViewModel: ConverterViewModel!
    var buttonTapped: ButtonTapped!
    
    lazy var dataSource = CurrenciesDataSource(viewModel: viewModel)
    lazy var delegate = CurrenciesDelegate(viewModel: viewModel, converterViewModel: converterViewModel, buttonTapped: buttonTapped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarBar()
        setupSearchBar()
        
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }

    func setupNavigationBarBar() {
        navigationItem.rightBarButtonItem = orderBarItem
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Pesquisar moeda"
    }
    
    func createOrderButton(_ title: OrderButtonTitle) -> UIBarButtonItem {
        let button = UIButton()
        button.setTitle(title.rawValue, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
    @objc func orderButtonTapped() {
        orderButtonType = orderButtonType == .name ? .code : .name
        navigationItem.rightBarButtonItem = createOrderButton(orderButtonType)
        
        dataSource.orderCurrencies(by: orderButtonType)
        tableView.reloadData()
    }
    
    func resetTableView() {
        viewModel.currencies = viewModel.currencies
        dataSource.orderCurrencies(by: orderButtonType)
        tableView.reloadData()
    }
}

extension CurrencyListViewController: CurrencyListViewModelDelegate {
    func didFinishLoadCurrencyListWithSuccess(_ currencies: [CurrencyModel]) {
        DispatchQueue.main.async {
            self.viewModel.currencies = currencies
            self.tableView.reloadData()
        }
    }
    
    func didFinishLoadCurrencyValuesInDollarWithSuccess(_ currencies: [CurrencyModel]) {
        DispatchQueue.main.async {
            self.viewModel.currencies = currencies
            self.tableView.reloadData()
        }
    }
    
}

extension CurrencyListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard searchText.count > 0 else {
            dataSource.orderCurrencies(by: orderButtonType)
            resetTableView()
            return
        }
        
        viewModel.currencies = viewModel.currencies.filter({ currency in
            return currency.code.uppercased().contains(searchText.uppercased()) || currency.name.uppercased().contains(searchText.uppercased())
        })
        
        dataSource.orderCurrencies(by: orderButtonType)
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        resetTableView()
    }
}

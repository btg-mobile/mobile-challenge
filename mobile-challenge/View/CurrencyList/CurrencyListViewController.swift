//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 25/09/20.
//

import UIKit

class CurrencyListViewController: UIViewController {

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = self
        searchBar.placeholder = "Pesquisar moeda"
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        return tableView
    }()
    
    var safearea: UILayoutGuide!
    
    var orderButtonType: OrderButtonTitle = .code
    lazy var orderBarItem: UIBarButtonItem = createOrderButton(orderButtonType)
    
    
    lazy var dataSource = CurrenciesDataSource(viewModel: viewModel)
    lazy var delegate = CurrenciesDelegate(viewModel: viewModel, converterViewModel: converterViewModel, buttonTapped: buttonTapped)
    
    let viewModel: CurrencyListViewModel
    let converterViewModel: ConverterViewModel
    let buttonTapped: ButtonTapped
    
    init(viewModel: CurrencyListViewModel, converterViewModel: ConverterViewModel, buttonTapped: ButtonTapped) {
        self.viewModel = viewModel
        self.converterViewModel = converterViewModel
        self.buttonTapped = buttonTapped
        
        super.init(nibName: nil, bundle: nil)
        
        safearea = view.layoutMarginsGuide
        
        setupViews()
        setupUI()
        setupNavigationBarBar()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchViewModelCurrencies()
    }
    
    lazy var networkErrorHandler: ((NetworkError?) -> Void) = { error in
        if let error = error {
            switch error {
            case .offline:
                let hasData = self.viewModel.retrieveCurrencies()
                if hasData {
                    self.reloadTableViewData()
                }
                else {
                    self.showAlert(title: error.errorDescription)
                }
            default:
                self.showAlert(title: error.errorDescription)
            }
        }
    }
    
    func fetchViewModelCurrencies() {
        self.viewModel.fetchCurrencies(errorHandler: self.networkErrorHandler)
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
        
        viewModel.orderCurrencies(by: orderButtonType)
        tableView.reloadData()
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func resetCurrencies() {
        self.viewModel.currencies = self.viewModel.currenciesBackup
        self.viewModel.orderCurrencies(by: self.orderButtonType)
    }
    
    func showAlert(title: String? = "", message: String? = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let tryAgainAction = UIAlertAction(title: "Tentar novamente", style: .default) { _ in
            self.fetchViewModelCurrencies()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(tryAgainAction)
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

extension CurrencyListViewController {
    func setupUI() {
        view.backgroundColor = .white
    }
    
    func setupNavigationBarBar() {
        navigationItem.rightBarButtonItem = orderBarItem
    }
    
    func setupTableView() {
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: "cell")
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
        
//        guard searchText.count > 0 else {
//            viewModel.orderCurrencies(by: orderButtonType)
//            resetCurrencies()
//            reloadTableViewData()
//            return
//        }
        
//        viewModel.currencies = viewModel.currencies.filter({ currency in
//            return currency.code.uppercased().contains(searchText.uppercased()) || currency.name.uppercased().contains(searchText.uppercased())
//        })
//
        viewModel.search(searchText)
        viewModel.orderCurrencies(by: orderButtonType)
        reloadTableViewData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
//        resetCurrencies()
//        reloadTableViewData()
    }
}

extension CurrencyListViewController: ViewCodable {
    func setupHierarchyViews() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        setupSearchBarConstraints()
        setupTableViewConstraints()
    }
    
    func setupSearchBarConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safearea.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

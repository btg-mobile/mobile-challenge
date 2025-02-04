//
//  CurrencyListingViewController.swift
//  MobileChallenge
//
//  Created by Gabriel Vicentin Negro on 18/11/24.
//

import UIKit
import Combine

class CurrencyListingViewController: UIViewController {
    
    //MARK: ViewModels
    var listOfCurrencyViewModel: ListOfCurrencyViewModel
    var liveValueViewModel: LiveValueViewModel
    
    //MARK: Variables
    var fromOrTo: FromOrTo = .from
    
    var tableViewCurrencyDataSource: TableViewCurrencyDataSource?
    var tableViewCurrencyDelegate: TableViewCurrencyDelegate?
    var searchBarDelegate: SearchBarDelegate?
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: UIComponents
    private let tableViewCurrency: UITableView = UITableView()
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Carregando"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = "Search Currency"
        searchBar.searchTextField.backgroundColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        return button
    }()
    
    init(listOfCurrencyViewModel: ListOfCurrencyViewModel, liveValueViewModel: LiveValueViewModel) {
        self.listOfCurrencyViewModel = listOfCurrencyViewModel
        self.liveValueViewModel = liveValueViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.overrideUserInterfaceStyle = .light
        
        loadUIWithData()
        bindViewModel()
        listOfCurrencyViewModel.getListOfCurrency()
    }
    
    func removeLoadingText() {
        self.loadingLabel.removeFromSuperview()
    }
    
    func loadUIWithData() {
        
        createDataSourceAndDelegate()
//        addFilterButton()
        addSearchBar()
        addTableViewCurrency()
        addDoneButtonToKeyboard()
        addGestureToDismissKeyboard()
    }
    
    //funcao que cria o delegate e datasource com dados vazios
    func createDataSourceAndDelegate() {
        self.tableViewCurrencyDataSource = TableViewCurrencyDataSource(listOfCurrencyNames: [], listOfCurrencyCodes: [])
        self.tableViewCurrencyDelegate = TableViewCurrencyDelegate(viewController: self, liveValueViewModel: liveValueViewModel, listOfCurrencyViewmodel: listOfCurrencyViewModel)
        self.searchBarDelegate = SearchBarDelegate(listOfCurrencyViewModel: listOfCurrencyViewModel)
        
        self.tableViewCurrency.dataSource = self.tableViewCurrencyDataSource
        self.tableViewCurrency.delegate = self.tableViewCurrencyDelegate
        self.searchBar.delegate = self.searchBarDelegate
        
    }
    
    func addFilterButton() {
        self.view.addSubview(filterButton)
        NSLayoutConstraint.activate([
            filterButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            filterButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10)
        ])
    }
    
    
    func addSearchBar() {
        self.view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5)
        ])
    }
    
    func addTableViewCurrency() {
        self.tableViewCurrency.register(TableViewCurrencyCell.self, forCellReuseIdentifier: TableViewCurrencyCell.identifier)
        self.view.addSubview(tableViewCurrency)
        self.tableViewCurrency.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableViewCurrency.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableViewCurrency.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableViewCurrency.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 20),
            tableViewCurrency.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10)
        ])
    }
    
    func addDoneButtonToKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.items = [doneButton]
        
        searchBar.inputAccessoryView = toolbar
    }
    
    func addGestureToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    //Funcao chamada quando eu receber os dados atualizados da minha viewmodel na requisicao da api
    func updateDataSourceAndDelegate(with currencies: [String: String]) {
        let sortedListOfCurrency = currencies.sorted { $0.key < $1.key }
        let listOfCurrencyNames = sortedListOfCurrency.map { $0.value }
        let listOfCurrencyCodes = sortedListOfCurrency.map { $0.key }
        
        self.tableViewCurrencyDataSource?.listOfCurrencyNames = listOfCurrencyNames
        self.tableViewCurrencyDataSource?.listOfCurrencyCodes = listOfCurrencyCodes
        
        self.tableViewCurrency.reloadData()
    }
    
    //Funcao chamada quando eu filtrar os dados da searchbar
    func filterCurrencyTableView(with currencies: [String: String]) {
        let listOfCurrencyNames = currencies.map { $0.value }
        let listOfCurrencyCodes = currencies.map { $0.key }
        
        self.tableViewCurrencyDataSource?.listOfCurrencyNames = listOfCurrencyNames
        self.tableViewCurrencyDataSource?.listOfCurrencyCodes = listOfCurrencyCodes
        
        self.tableViewCurrency.reloadData()
    }
    
    func bindViewModel() {
        listOfCurrencyViewModel.$currencies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currencies in
                //Nesse momento eu tenho os dados brutos da api
                self?.updateDataSourceAndDelegate(with: currencies)
            }
            .store(in: &cancellables)
        
        listOfCurrencyViewModel.$filteredCurrencies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currencies in
                //nesse momento eu tenho os dados filtrados pela barra de pesquisa
                self?.filterCurrencyTableView(with: currencies)
            }
            .store(in: &cancellables)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

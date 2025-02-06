//
//  CurrencyViewController.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import UIKit

class CurrencyViewController: UIViewController, UISearchBarDelegate {

    

    
    weak var currencyCellDelegate: CurrencyCellDelegate?

    var currencyViewModel: CurrencyViewModel
    
    var filteredCurrency: [String : String]? {
        didSet {
            updateTableView()
        }
    }
    
    init(currencyViewModel: CurrencyViewModel) {
        self.currencyViewModel = currencyViewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Procure uma moeda"
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        return searchBar
    }()
    
    let text: UILabel = {
        let text = UILabel()
        text.text = "Carregando..."
        text.textColor = .gray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var isLoading: Bool = true
    var tableViewDataSource: CurrencyTableViewDataSource?
    var tableViewDelegate: CurrencyTableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        setIsLoadingText()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {

        Task {
            await fetchCurrencyResponse()

        }
        
    }
    
    func fetchCurrencyResponse() async {
        do {
            let data = try await currencyViewModel.getCurrencyData()
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.tableViewDataSource = CurrencyTableViewDataSource(currencyResponse: data)
                self?.tableViewDelegate = CurrencyTableViewDelegate(currencyResponse: data)
                self?.tableViewDelegate?.currencyCellDelegate = self?.currencyCellDelegate
                self?.tableViewDataSource?.currencyResponse = data
                self?.tableView.delegate = self?.tableViewDelegate
                self?.tableView.dataSource = self?.tableViewDataSource
                self?.isLoading = false
                self?.setTableView()
            }
        } catch ServiceError.invalidData{
            print("Error type data")
        } catch ServiceError.invalidResponse {
            print("Error type response")
        } catch ServiceError.invalidURL {
            print("Error type URL")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    

    func setIsLoadingText() {
        
        if isLoading {
            self.view.addSubview(text)
            
            NSLayoutConstraint.activate([
                text.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                text.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        } else {
            text.removeFromSuperview()
        }
        
    }
    
    func setTableView() {
        self.view.addSubview(searchBar)
        searchBar.delegate = self

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
        ])
        
    
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        

    }
    
    func updateTableView() {
        if let filteredCurrency = filteredCurrency {
            self.tableViewDataSource?.currencyResponse = filteredCurrency
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCurrency = currencyViewModel.filterCurrency(searchBarText: searchText)
    }
     


}


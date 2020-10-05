//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 04/10/20.
//

import UIKit

protocol SelectCurrencyDelegate: class {
    func getSelectCurrency(type: TypeConverter, currency: Currency) -> Void
}

enum TypeConverter: String {
    case origin
    case destiny
}

class CurrencyListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CurrencyListViewModel
    private let cellIdentifier = "currencyCell"
    var delegate: SelectCurrencyDelegate?
    
    init(type: TypeConverter) {
        self.viewModel = CurrencyListViewModel(type: type)
        super.init(nibName: "CurrencyListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        
        setupTableView()
        fetchCurrencyList()
    }
    
    func setupTableView() -> Void {
        tableView.register(CurrencyUiTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func fetchCurrencyList() {
        
        CurrencyAPI.shared.fetchCurrencyList { (result) in
            switch result {
            case .success(let list):
                if let currencies = list.currencies {
                    DispatchQueue.main.async {
                        self.viewModel.currencies = currencies.map { return Currency(code: $0.key, description: $0.value) }

                        self.tableView.reloadData()
                    }
                }
            case .error(let error):
                print("List: ", error)
            }
        }
        
    }
    
}

// MARK: Delegate and DataSource

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentSelect = viewModel.currencies[indexPath.row]
        
        delegate?.getSelectCurrency(type: viewModel.typeConverter, currency: currentSelect)
        
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CurrencyUiTableViewCell
        else { return CurrencyUiTableViewCell() }

        let currentCurrency = viewModel.currencies[indexPath.row]
        
        cell.setup(currency: currentCurrency)
        
        return cell
    }
    
}


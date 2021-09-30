//
//  CurrencyListController.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import UIKit

final class CurrencyListController: UIViewController {
    
    private lazy var viewModel = CurrencyListViewModel(delegate: self)
    private lazy var customView = CurrencyListView(delegate: self, dataSource: self)
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Currencies"
    }
    
}

// MARK: - Private Methods
extension CurrencyListController {
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}

extension CurrencyListController: CurrencyListViewModelDelegate {
    func didReloadData() {
        customView.tableView.reloadData()
    }
    
    func failedToGetCurrencyList() {
        
    }
    
}

// MARK: - TableView Extensions
extension CurrencyListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
}

extension CurrencyListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrencyCell.self)) as? CurrencyCell, let info = viewModel.filteredData else {
            return UITableViewCell()
        }
        cell.setupInfos(info[indexPath.row])
        return cell
    }
    
}

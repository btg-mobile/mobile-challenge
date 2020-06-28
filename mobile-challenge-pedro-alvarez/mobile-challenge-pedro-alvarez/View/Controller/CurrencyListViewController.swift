//
//  CurrencyListViewController.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    private(set) var finishCallback: SimpleCallbackType
    
    private(set) var factory: CurrencyTableViewFactory?
    
    private(set) var dataSource: DefaultTableViewOutput?
    
    private(set) var viewModel: CurrencyListViewModelProtocol?
    
    private lazy var tableView: CurrencyListTableView = {
        return CurrencyListTableView(frame: .zero)
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCloseButton))
    }()

    private lazy var errorView: ErrorView = {
        return ErrorView(frame: .zero, errorMessage: .empty)
    }()
    
    private lazy var mainView: CurrencyListView = {
        return CurrencyListView(frame: .zero,
                                tableView: tableView,
                                errorView: errorView)
    }()
    
    init(finishCallback: @escaping SimpleCallbackType) {
        self.finishCallback = finishCallback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.fetchCurrencies()
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
}

extension CurrencyListViewController: DefaultTableViewOutputDelegate {
    
    func didSelectRow(indexPath: IndexPath) {
        viewModel?.didSelectCurrency(index: indexPath.row)
    }
}

extension CurrencyListViewController {
    
    private func setupDataSource() {
        guard let sections = factory?.buildSections() else { return }
        dataSource = DefaultTableViewOutput(sections: sections)
    }
    
    private func setupTableView() {
        guard let dataSource = dataSource else { return }
        tableView.assignProtocols(to: dataSource)
    }
    
    private func setupFactory() {
        guard let viewModel = viewModel else { return }
        factory = CurrencyTableViewFactory(viewModel: viewModel, tableView: tableView)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func refreshList() {
        setupDataSource()
        setupFactory()
    }
    
    private func setup() {
        title = Constants.Titles.currencyListTitle
        setupTableView()
        refreshList()
        viewModel?.fetchCurrencies()
    }
    
    @objc
    private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
}

extension CurrencyListViewController: CurrencyListViewModelDelegate {
    
    func didFetchCurrencies() {
        refreshList()
    }
    
    func didFetchSelectedCurrency(id: String) {
        dismiss(animated: true, completion: nil)
        finishCallback()
    }
    
    func didGetError(_ error: String) {
        mainView.displayError(withMessage: error)
    }
}

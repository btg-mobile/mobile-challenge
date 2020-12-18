//
//  CurrencyListViewController.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 18/12/20.
//

import UIKit

class CurrencyListViewController: UIViewController, ViewCodable {

    private weak var coordinator: (MainCoordinator & CurrencyChoosing)?
    private var viewModel: CurrencyListViewModel?
    private var tableView: UITableView?
    private let tableViewDataSource = CurrencyListTableViewDataSource()
    private let tableViewDelegate = TableViewDelegate()
    private var onSelectCurrency: (Currency) -> Void = { _ in }

    init(coordinator: (MainCoordinator & CurrencyChoosing),
         onSelectCurrency: @escaping (Currency) -> Void) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        self.onSelectCurrency = onSelectCurrency
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setConstraints()
    }

    func setUp() {
        navigationItem.title = LiteralText.originViewControllerTitle

        let service = CurrencyListService(network: APIClient.shared)
        viewModel = CurrencyListViewModel(service: service) { [weak self] in
            self?.updateUI()
        }

        guard let viewModel = viewModel else { return }

        tableViewDataSource.setNumberOfRows = {
            return viewModel.currencies.count
        }
        tableViewDataSource.getCurrencyForRowAt = { row in
            return viewModel.currencies[row]
        }

        tableViewDelegate.didSelectRowAt = { [weak self] row in
            self?.onSelectCurrency(viewModel.currencies[row])
            self?.coordinator?.goBack()
        }

        tableView = UITableView()
        tableView?.dataSource = tableViewDataSource
        tableView?.delegate = tableViewDelegate
    }

    func setConstraints() {
        guard let tableView = tableView else { return }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func updateUI() {
        tableView?.reloadData()
    }
}

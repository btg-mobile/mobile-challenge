//
//  ListViewController.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import UIKit

protocol ListDelegate: class {
    func didSelectCurrency(_ currency: Currecy, type: CurrencyType)
}

class ListViewController: UIViewController {

    private let viewModel: ListViewModel
    weak var delegate: ListDelegate?
    
    // MARK: - Layout Vars
    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(close))
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped).useConstraint()
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.description())
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .lightGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        return tableView
    }()
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        viewModel = ListViewModel(type: .origin)
        super.init(coder: coder)
    }
    
    init(type: CurrencyType) {
        viewModel = ListViewModel(type: type)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        viewModel.delegate = self
        viewModel.availableCurrrencies()
    }
    
    // MARK: - Setups
    private func setupLayout() {
        title = "Currency"
        navigationItem.setRightBarButton(closeButton, animated: false)
        view.backgroundColor = .black
        view.addSubview(tableView)
        tableView
            .top(anchor: view.safeAreaLayoutGuide.topAnchor)
            .leading(anchor: view.safeAreaLayoutGuide.leadingAnchor)
            .trailing(anchor: view.safeAreaLayoutGuide.trailingAnchor)
            .bottom(anchor: view.bottomAnchor)
    }
    
    // MARK: - Actions
    @objc private func close() {
        dismiss(animated: true)
    }
}

// MARK: - View Model
extension ListViewController: ListViewModelDelegate {
    func onListCurrencies() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func onError(_ error: NSError) {
        print(error.localizedDescription)
    }
}

// MARK: - TableView
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.description(), for: indexPath) as? CurrencyTableViewCell
        cell?.title = viewModel.currencies[indexPath.row].code
        cell?.subtitle = viewModel.currencies[indexPath.row].name
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = viewModel.currencies[indexPath.row]
        delegate?.didSelectCurrency(currency, type: viewModel.type)
        dismiss(animated: true)
    }
}

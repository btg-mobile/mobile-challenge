//
//  CurrencyListController.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 01/04/21.
//

import UIKit

class CurrencyListController: BaseViewController {
    
    // MARK: - Properties
    
    var viewModel: CurrencyViewModel
    
    private lazy var contentView: CurrencyListView = {
        let view = CurrencyListView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.register(CurrencyListCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
    }
    
    init(viewModel: CurrencyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        fetchValue()
        fetchDetails()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    private func fetchValue() {
        self.viewModel.fetchCurrentValue { success in
            if success {
                self.contentView.tableView.reloadData()
            } else {
                self.handleError()
            }
        }
    }
    
    private func fetchDetails() {
        self.viewModel.fetchDetails { success in
            if success {
                self.contentView.tableView.reloadData()
            } else {
                self.handleError()
            }
        }
    }
    
    private func handleError() {
        print("Erro")
    }
    
}

// MARK: - Extensions

extension CurrencyListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.modelDetails?.currencies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyListCell
        let keyArray = viewModel.convertDicKeyToArray()
        let valueArray = viewModel.convertDicValueToArray()
        cell.setup("\(keyArray[indexPath.row])","\(valueArray[indexPath.row]))")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyArray = viewModel.convertDicKeyToArray()[indexPath.row]
        viewModel.gettingCountryAcronym(country: keyArray)
        dismiss(animated: true, completion: nil)
    }
}

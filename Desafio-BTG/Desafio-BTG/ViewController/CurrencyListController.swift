//
//  CurrencyListController.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 01/04/21.
//

import UIKit

class CurrencyListController: BaseViewController {
    
    // MARK: - Properties
    
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
    
    override func loadView() {
        self.view = contentView
    }
    
}

// MARK: - Extensions

extension CurrencyListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyListCell
        cell.setup("USD", "United State")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

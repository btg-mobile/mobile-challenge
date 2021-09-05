//
//  CurrencyListScreen.swift
//  Curriencies
//
//  Created by Ferraz on 04/09/21.
//

import UIKit

final class CurrencyListScreen: UIView {
    typealias TableViewDelegate = UITableViewDelegate & UITableViewDataSource
    
    let tableViewDelegate: TableViewDelegate
    
    private lazy var currencyList: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = tableViewDelegate
        tableView.delegate = tableViewDelegate
        tableView.register(CurrencyTableViewCell.self,
                           forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    init(tableViewDelegate: TableViewDelegate) {
        self.tableViewDelegate = tableViewDelegate
        super.init(frame: .zero)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CurrencyListScreen: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(views: [currencyList])
    }
    
    func makeConstraints() {
        currencyList
            .make([.top, .leading, .trailing, .bottom], equalTo: self)
    }
}

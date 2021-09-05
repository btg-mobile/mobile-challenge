//
//  CurrencyListScreen.swift
//  Curriencies
//
//  Created by Ferraz on 04/09/21.
//

import UIKit

final class CurrencyListScreen: UIView {
    typealias TableViewDelegate = UITableViewDelegate & UITableViewDataSource
    
    private let tableViewDelegate: TableViewDelegate
    private let searchBarDelegate: UISearchBarDelegate
    
    private lazy var currencyList: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = tableViewDelegate
        tableView.delegate = tableViewDelegate
        tableView.register(CurrencyTableViewCell.self,
                           forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var currencySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = searchBarDelegate
        searchBar.showsCancelButton = true
        searchBar.isTranslucent = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    init(tableViewDelegate: TableViewDelegate, searchBarDelegate: UISearchBarDelegate) {
        self.tableViewDelegate = tableViewDelegate
        self.searchBarDelegate = searchBarDelegate
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
        addSubviews(views: [currencyList,
                            currencySearchBar])
    }
    
    func makeConstraints() {
        currencySearchBar
            .make([.top, .leading, .trailing], equalTo: self)
            .make(.height, equalTo: 50)
        
        currencyList
            .make([.leading, .trailing, .bottom], equalTo: self)
            .make(.top, equalTo: currencySearchBar, attribute: .bottom)
    }
}

extension CurrencyListScreen {
    func reloadTableView() {
        currencyList.reloadData()
    }
}

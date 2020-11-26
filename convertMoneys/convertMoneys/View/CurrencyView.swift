//
//  CurrencyView.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import UIKit

class CurrencyView: UIView {
    //TableView
    lazy var tableView: CurrencyTableView = {
        let tableView = CurrencyTableView()
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    //Search Controller
    let searchController: UISearchController = {
        let searchController = UISearchController()
        return searchController
    }()
    
    init() {
        super.init(frame: .zero)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrencyView:ViewCodable{
    func setupViewHierarchy() {
        self.addSubview(tableView)
//        self.addSubview(searchController.searchBar)
    }
    
    func setupConstraints() {
    
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
}

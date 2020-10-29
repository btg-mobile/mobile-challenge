//
//  CurrencyListView.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

class CurrencyListView: UIView {
    
    // MARK: - Properties
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(CurrencyListTableViewCell.self, forCellReuseIdentifier: CurrencyListTableViewCell.uniqueIdentifier)
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupViews()
    }
    
    private func setupUI(){
        self.backgroundColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: - View Codable Protocol

extension CurrencyListView: ViewCodable {
    
    func setupViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints(){
        self.tableView.anchor(top: topAnchor)
        self.tableView.anchor(left: leftAnchor)
        self.tableView.anchor(right: rightAnchor)
        self.tableView.anchor(bottom: bottomAnchor)
    }
}

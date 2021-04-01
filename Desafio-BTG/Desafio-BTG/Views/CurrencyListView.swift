//
//  CurrencyListView.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 01/04/21.
//

import UIKit

class CurrencyListView: UIView {
    
    // MARK: - Properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    // MARK: - Override & Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.backgroundColor = .clear
    }
    
    // MARK: - Private functions
    
    private func setupViewHierarchy() {
        self.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 24).isActive = true
    }
}

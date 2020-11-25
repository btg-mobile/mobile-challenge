//
//  CurrencyView.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import UIKit

class CurrencyView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: self.heightAnchor),
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}

extension CurrencyView:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier) as? CurrencyTableViewCell else{return UITableViewCell()}
        
        cell.currencyLabel.text = "2s pau"
        cell.backgroundColor = .gray
        
        return cell
    }
}

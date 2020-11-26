//
//  CurrencyView.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import UIKit

class CurrencyView: UIView {
    
    let viewModel = CurrencyViewModel()
    
    lazy var tableView: CurrencyTableView = {
        let tableView = CurrencyTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
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
        return viewModel.allCurrenciesNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier) as? CurrencyTableViewCell else{return UITableViewCell()}
        
        viewModel.configureCurrencyName(cell,indexPath.row)
        
        cell.backgroundColor = .gray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CurrencyTableViewCell
        
        viewModel.delegate?.notifyChooseCurrency(nameCurrency: cell.nameCurrency, quote: cell.quote,destiny: viewModel.myDestinyData)
        
    }
}

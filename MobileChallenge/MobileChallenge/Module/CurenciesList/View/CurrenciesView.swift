//
//  CurrenciesView.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//


import UIKit

class CurrenciesView: UIView{
    
    lazy var currenciesTableView: UITableView = {
        let tableView = UITableView(frame: self.frame)
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrenciesView: ViewCodable{
    
    func setupViewHierarchy() {
        self.addSubview(currenciesTableView)
    }
    
    func setupConstraints() {
        currenciesTableView.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        currenciesTableView.anchor(bottom: self.bottomAnchor, paddingBottom: 0)
        currenciesTableView.anchor(left: self.leftAnchor, paddingLeft: 0)
        currenciesTableView.anchor(right: self.rightAnchor, paddingRight: 0)
    }
}

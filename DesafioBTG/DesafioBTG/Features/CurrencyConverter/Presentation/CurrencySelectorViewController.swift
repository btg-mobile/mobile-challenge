//
//  CurrencySelectorViewController.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 03/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import UIKit
import RxSwift

class CurrencySelectorViewController: UIViewController {
    // MARK: UI Components
    let tableView = UITableView()
    
    // MARK: Variables
    public var viewModel: CurrencySelectorViewModel!
    let disposeUIBag = DisposeBag()
    private var firstAppearing = true
    public var isSelectingFirstCurrency = true
    
    private var currencies: [Currency] = []
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if firstAppearing {
            self.setupUI()
            self.bindUI()
            self.firstAppearing = false
        }
        
        self.showObstructiveLoading()
        self.viewModel.rx_updateCurrenciesList().subscribe(onNext: {[weak self] _ in
            guard let self = self else {return}
            self.hideObstructiveLoading()
            self.currencies = self.viewModel.getCurrencies()
            self.tableView.reloadData()
        }, onError: { error in
            //TO-DO: TRATAR ERRO
            self.hideObstructiveLoading()
        }).disposed(by: self.disposeUIBag)
    }
    
    // MARK: - Setup UI
    func setupUI(){
        setupTableView()
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        
        var topAnchor: NSLayoutYAxisAnchor!
        var bottomAnchor: NSLayoutYAxisAnchor!
        
        if #available(iOS 11.0, *) {
            topAnchor = self.view.safeAreaLayoutGuide.topAnchor
            bottomAnchor = self.view.safeAreaLayoutGuide.bottomAnchor
        } else {
            topAnchor = self.view.topAnchor
            bottomAnchor = self.view.bottomAnchor
        }
        
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CurrencySelectorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.currencies[indexPath.row].code + " - " + self.currencies[indexPath.row].name.capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isSelectingFirstCurrency {
            self.viewModel.setFirstCurrency(self.currencies[indexPath.row])
        } else {
            self.viewModel.setSecondCurrency(self.currencies[indexPath.row])
        }
    }
}

//
//  CoinListTableView.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

class CoinListTableView: UITableView {

    // MARK: - Properties
    
    fileprivate var viewModel = CoinListTableViewModel()
    
    init() {
        super.init(frame: .zero, style: .plain)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(viewModel: CoinListTableViewModel) {
        self.viewModel = viewModel
        reloadData()
    }
    
    fileprivate func setup() {
        delegate = self
        dataSource = self
        
        tableFooterView = UIView()
        separatorInset = UIEdgeInsets(top: 0, left: CoinListCell.labelMargin, bottom: 0, right: CoinListCell.labelMargin)
        
        registerClass(CoinListCell.self)
    }
    
}

extension CoinListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(CoinListCell.self, indexPath: indexPath)
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        cell.update(viewModel: cellViewModel)
        
        return cell
    }
}

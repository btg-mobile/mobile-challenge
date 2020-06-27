//
//  CurrencyListView.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class CurrencyListView: UIView {
    
    private unowned var tableView: CurrencyListTableView
    
    private lazy var activityView: UIActivityIndicatorView = {
        return UIActivityIndicatorView(frame: .zero)
    }()
    
    init(frame: CGRect,
                  tableView: CurrencyListTableView) {
        self.tableView = tableView
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

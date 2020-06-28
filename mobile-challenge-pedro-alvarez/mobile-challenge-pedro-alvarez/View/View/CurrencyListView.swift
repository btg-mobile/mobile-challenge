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
    private unowned var errorView: ErrorView
    
    private lazy var activityView: UIActivityIndicatorView = {
        return UIActivityIndicatorView(frame: .zero)
    }()
    
    var animating: Bool = false {
        didSet {
            activityView.isHidden = !animating
        }
    }
    
    init(frame: CGRect,
         tableView: CurrencyListTableView,
         errorView: ErrorView) {
        self.tableView = tableView
        self.errorView = errorView
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayError(withMessage message: String) {
        errorView.errorMessage = message
        errorView.isHidden = false
    }
}

extension CurrencyListView: ViewCodeProtocol {
    
    func buildHierarchy() {
        addSubview(tableView)
        addSubview(activityView)
    }
    
    func setupConstraints() {
        
    }
    
    func configureViews() {
        activityView.backgroundColor = .black
        activityView.color = .white
        activityView.startAnimating()
        activityView.isHidden = true
    }
}

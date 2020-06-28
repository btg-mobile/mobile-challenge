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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: activityView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: activityView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: activityView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: activityView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: errorView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: errorView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: errorView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: errorView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func configureViews() {
        activityView.backgroundColor = .black
        activityView.color = .white
        activityView.startAnimating()
        activityView.isHidden = true
    }
}

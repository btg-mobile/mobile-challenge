//
//  CurrencyListView.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import UIKit

class CurrencyListView: UIStackView {

    var tableView: CurrencyTableView = {
        let tableView = CurrencyTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    var sortSegmentedControl: UISegmentedControl {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "Nome", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Código", at: 1, animated: true)
        segmentedControl.addTarget(self, action: #selector(didChangeSort), for: .valueChanged)
        return segmentedControl
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .vertical
        alignment = .center
        distribution = .equalSpacing
        spacing = 0
        
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didChangeSort() {
        
    }
    
}

extension CurrencyListView: ViewCodable {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor)
                        
//            sortSegmentedControl.topAnchor.constraint(equalTo: topAnchor),
//            sortSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor),
//            sortSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupViewHierarchy() {
        addArrangedSubview(sortSegmentedControl)
        addArrangedSubview(tableView)
    }
}

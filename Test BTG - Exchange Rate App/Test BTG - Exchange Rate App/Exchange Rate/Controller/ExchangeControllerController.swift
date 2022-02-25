//
//  ExchangeControllerController.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 25/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import UIKit

class ExchangeControllerController: UIViewController {
    
    // MARK: - Properties
    
    private let instructionsLabel   = { return UILabelDefault() }()
    
    private let stackView           = { return UIStackView() }()
    
    private let exchangeTableView   = { return UITableView() }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegate()
        setupDataSource()
        
        applyViewCode()
    }
    
    // MARK: - Methods
    
    private func setupDelegate() {
        exchangeTableView.delegate = self
    }
    
    private func setupDataSource() {
        exchangeTableView.dataSource = self
    }

}

// MARK: - UITableViewDelegate

extension ExchangeControllerController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: TableView cell \(indexPath.row) pressed!")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

// MARK: - UITableViewDataSource

extension ExchangeControllerController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeRateTableViewCell.identifier, for: indexPath)
        
        
        return cell
    }
    
}

// MARK: - ViewCodeConfiguration

extension ExchangeControllerController: ViewCodeConfiguration {
    public func configureViews() {
        
        configureGradientLayer()
        
        instructionsLabel.text = "Tap to choose currencies"
        instructionsLabel.font = instructionsLabel.font.withSize(13)
        
        stackView.axis      = .vertical
        stackView.spacing   = 20

        exchangeTableView.layer.cornerRadius = 10
        exchangeTableView.register(ExchangeRateTableViewCell.self,
                                   forCellReuseIdentifier: ExchangeRateTableViewCell.identifier)
    }
    
    public func buildHierarchy() {
        
        view.addSubview(stackView)
        view.addSubview(instructionsLabel)
        
        stackView.addArrangedSubview(exchangeTableView)
        
    }
    
    public func setupConstraints() {
        
        stackView.centerY(inView: view)
        stackView.anchor(
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        instructionsLabel.anchor(
            left: stackView.leftAnchor,
            bottom: exchangeTableView.topAnchor,
            paddingLeft: 13,
            paddingBottom: 3,
            height: 15
        )
        
        exchangeTableView.anchor(
            height: 111
        )
    }
}

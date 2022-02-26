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
    
    private let logoImageView       = { return UIImageView(frame: .zero) }()
    
    private let instructionsLabel   = { return UILabelDefault() }()
    private let resultAmountLabel   = { return UILabelDefault() }()
    private let resultCodeLabel     = { return UILabelDefault() }()
    
    private let stackView           = { return UIStackView() }()
    
    private let exchangeTableView   = { return UITableView() }()
    
    private let amountTextField     = { return UITextFieldDefault() }()
    
    private let resultView          = { return UIView(frame: .zero) }()
    
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

// MARK: - ViewCodeConfiguration

extension ExchangeControllerController: ViewCodeConfiguration {
    public func configureViews() {
        
        configureGradientLayer()
        
        logoImageView.image = #imageLiteral(resourceName: "btgp-white")
        logoImageView.contentMode = .scaleAspectFit
        
        instructionsLabel.text = "Tap to choose currencies"
        instructionsLabel.font = instructionsLabel.font.withSize(13)
        
        stackView.axis      = .vertical
        stackView.spacing   = 20

        exchangeTableView.layer.cornerRadius = 10
        exchangeTableView.isScrollEnabled = false
        exchangeTableView.register(ExchangeRateTableViewCell.self,
                                   forCellReuseIdentifier: ExchangeRateTableViewCell.identifier)
        
        resultCodeLabel.text = "-"
        resultCodeLabel.font = resultCodeLabel.font.withSize(34)
        
        resultAmountLabel.text  = "-"
        resultAmountLabel.font  = resultAmountLabel.font.withSize(34)
        
        amountTextField.setPlaceholder("Type amount")
        amountTextField.setCurrencyCode("-")
        amountTextField.backgroundColor = .white
        amountTextField.keyboardType = .decimalPad
        
    }
    
    public func buildHierarchy() {
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(instructionsLabel)
        
        stackView.addArrangedSubview(exchangeTableView)
        stackView.addArrangedSubview(resultView)
        stackView.addArrangedSubview(amountTextField)
        
        resultView.addSubview(resultCodeLabel)
        resultView.addSubview(resultAmountLabel)
        
    }
    
    public func setupConstraints() {
        
        logoImageView.centerX(inView: view)
        logoImageView.anchor(
            bottom: stackView.topAnchor,
            paddingBottom: 55,
            width: 235,
            height: 145
        )
        
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
        
        resultView.anchor(
            height: 45
        )
        
        resultCodeLabel.anchor(
            top: resultView.topAnchor,
            left: resultView.leftAnchor,
            bottom: resultView.bottomAnchor,
            paddingLeft: 35
        )

        resultAmountLabel.anchor(
            top: resultView.topAnchor,
            bottom: resultView.bottomAnchor,
            right: resultView.rightAnchor,
            paddingRight: 35
        )
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

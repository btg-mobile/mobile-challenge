//
//  ExchangeControllerController.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 25/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import UIKit

class ExchangeController: UIViewController {
    
    // MARK: - Properties
    
    private let logoImageView       = { return UIImageView(frame: .zero) }()
    
    private let instructionsLabel   = { return UILabelDefault() }()
    
    private let stackView           = { return UIStackView() }()
    
    private let exchangeTableView   = { return UITableView() }()
    
    private let amountTextField     = { return UITextFieldDefault() }()
    
    private let resultView          = { return UIView(frame: .zero) }()
    
    private var resultAmountLabel   = { return UILabelDefault() }()
    private var resultCodeLabel     = { return UILabelDefault() }()
    
    private lazy var viewModel      = { return ExchangeRateViewModel() }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getData()
        
        setupDelegate()
        setupDataSource()
        
        applyViewCode()
        
        setupBindables()
        configureNotificationObservers()
    }
    
    // MARK: - Actions
    
    @objc func textDidChange(_ sender: UITextField) {
        viewModel.setBaseAmount(sender.text)
    }
    
    // MARK: - Methods
    
    private func setupDelegate() {
        exchangeTableView.delegate = self
    }
    
    private func setupDataSource() {
        exchangeTableView.dataSource = self
    }
    
    func setupBindables() {
        viewModel.currencyBaseCode.bind { [unowned self] (baseCode) in
            guard let baseCode = baseCode else { return }
            let baseCell = self.exchangeTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ExchangeRateTableViewCell
            baseCell.setCurrencyCode(baseCode)
            baseCell.setCurrencyRate(1.00)
            
            amountTextField.setCurrencyCode(baseCode)
        }
        viewModel.currencyEchangedCode.bind { [unowned self] (exchangedCode) in
            guard let exchangedCode = exchangedCode else { return }
            let exchangedCell = self.exchangeTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! ExchangeRateTableViewCell
            exchangedCell.setCurrencyCode(exchangedCode)
            
            resultCodeLabel.text = exchangedCode
        }
        viewModel.currencyEchangedRate.bind { [unowned self] (exchangedRate) in
            guard let exchangedRate = exchangedRate else { return }
            let exchangedCell = self.exchangeTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! ExchangeRateTableViewCell
            exchangedCell.setCurrencyRate(exchangedRate)
        }
        viewModel.resultAmountLabel.bind { [unowned self] (result) in
            guard let result = result else { return }
            resultAmountLabel.text = result
        }
    }
    
    func configureNotificationObservers() {
        amountTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
}

// MARK: - ViewCodeConfiguration

extension ExchangeController: ViewCodeConfiguration {
    public func configureViews() {
        
        setupBindables()
        
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

extension ExchangeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.setAsBaseCell(indexPath.row)
        
        let controller = CurrencyController()
        controller.delegate = self
        controller.currencyList = viewModel.getCurrenciesList()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}

// MARK: - UITableViewDataSource

extension ExchangeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeRateTableViewCell.identifier, for: indexPath)
        
        return cell
    }
    
}

// MARK: - CurrencyControllerProtocol

extension ExchangeController: CurrencyControllerProtocol {
    func selectCurrency(_ currency: CurrencyModel?) {
        self.viewModel.setSelectedCurrency(currency)
        self.exchangeTableView.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
}

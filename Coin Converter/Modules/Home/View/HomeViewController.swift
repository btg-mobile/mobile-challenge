//
//  HomeViewController.swift
//  Coin Converter
//
//  Created by Igor Custodio on 27/07/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Variables
    private var fromCurrencyButton: CCButton!
    private var targetCurrencyButton: CCButton!
    private var updateExchangeButton: CCButton!
    private var convertButton: CCButton!
    private var lastUpdateLabel: UILabel!
    private var textField: UITextField!
    private var stackView: UIStackView!
    private var titleConversion: UILabel!
    private var resultConversion: UILabel!
    
    private var viewModel: HomeViewModelProtocol!
    private weak var coordinator: MainCoordinator?
    
    private var isTextFieldAdded = false
    private var isResultAdded = false
    
    // MARK: - Initializer
    convenience init(viewModel: HomeViewModelProtocol, coordinator: MainCoordinator) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        setupUI()
        setupListeners()
        viewModel.getList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Navigation Controller settings
        navigationItem.title = Constants.homeTitle.rawValue
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = Constants.homeBackButtonTitle.rawValue
    }
    
    // MARK: - Setup methods
    private func setupDelegates() {
        viewModel.delegate = self
    }
    
    private func setupUI() {
        // Setup VC
        hideKeyboardOnTap()
        view.backgroundColor = UIColor(hex: Colors.background.rawValue)
        
        // Setup Elements
        setupTextField()
        setupButtons()
        setupLabels()
        
        // Create screen
        addMainStackView()
    }
    
    private func setupListeners() {
        fromCurrencyButton.addTarget(self, action: #selector(addOriginCurrencyButtonListener), for: .touchUpInside)
        targetCurrencyButton.addTarget(self, action: #selector(addTargetCurrencyButtonListener), for: .touchUpInside)
        updateExchangeButton.addTarget(self, action: #selector(addTargetUpdateExchangeButtonListener), for: .touchUpInside)
        convertButton.addTarget(self, action: #selector(addConvertButtonListener), for: .touchUpInside)
    }
}

// MARK: - TextField delegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let text = textField.text, let value = Double(text) else { return }
        viewModel.convertCurrency(value: value)
    }
}

// MARK: - Buttons Listeners
extension HomeViewController {
    @objc private func addOriginCurrencyButtonListener(_ sender: CCButton) {
        coordinator?.chooseCurrency(currencyList: viewModel.getCurrencies(), button: sender.tag, delegate: self)
    }
    
    @objc private func addTargetCurrencyButtonListener(_ sender: CCButton) {
        coordinator?.chooseCurrency(currencyList: viewModel.getCurrencies(), button: sender.tag, delegate: self)
    }
    
    @objc private func addTargetUpdateExchangeButtonListener(_ sender: CCButton) {
        viewModel.getList()
    }
    
    @objc private func addConvertButtonListener(_ sender: CCButton) {
        guard let text = textField.text, let value = Double(text) else { return }
        viewModel.convertCurrency(value: value)
    }
    
}

// MARK: - HomeViewDelegate methods
extension HomeViewController: HomeViewDelegate {
    func showAlertError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: title, style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        showLoadingView()
    }
    
    func hideLoading() {
        hideLoadingView()
    }
    
    func currencyListLoaded() {
        viewModel.getQuotesList()
    }
    
    func quotesListLoaded() {
        lastUpdateLabel.text = viewModel.getLastUpdatedText()
    }
    
    func currencyConverted() {
        handleConvertedValues()
        if !isResultAdded {
            stackView.insertArrangedSubview(addConvertedValueView(), at: 2)
            isResultAdded = true
        }
    }
}

// MARK: - ChooseCurrency Screen delegate
extension HomeViewController: ChooseCurrencyDelegate {
    func didSelectedCurrency(_ currency: Currency, button: Int) {
        switch button {
            case fromCurrencyButton.tag:
                fromCurrencyButton.setTitle(currency.initials, for: .normal)
                viewModel.setSelectedSourceCurrency(currency: currency)
                if !isTextFieldAdded {
                    stackView.insertArrangedSubview(addTextField(), at: 1)
                    isTextFieldAdded = true
                }
                
            case targetCurrencyButton.tag:
                targetCurrencyButton.setTitle(currency.initials, for: .normal)
                viewModel.setSelectedTargetCurrency(currency: currency)
            default:
                break
        }
    }
}


// MARK: - UI Elements
extension HomeViewController {
    private func setupTextField() {
        textField = UITextField()
        textField.delegate = self
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 16
        textField.addShadow()
        textField.leftViewMode = .always
        textField.keyboardType = .decimalPad
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: textField.frame.height))
        textField.leftView?.layoutIfNeeded()
    }
    
    private func setupButtons() {
        fromCurrencyButton = CCButton(title: "", style: .box)
        fromCurrencyButton.tag = 1
        targetCurrencyButton = CCButton(title: "", style: .box)
        targetCurrencyButton.tag = 2
        updateExchangeButton = CCButton(title: Constants.updateQuoteButton.rawValue, style: .link)
        convertButton = CCButton(title: Constants.convertButton.rawValue, style: .link)
    }
    
    private func setupLabels() {
        lastUpdateLabel = UILabel.createLabel(text: "",
                                              properties: UILabelProperties(alignment: .center, color: nil, size: 12))
        titleConversion = UILabel.createLabel(text: "",
                                              properties: UILabelProperties(alignment: .center, color: .init(hex: Colors.gray.rawValue), size: 16))
        resultConversion = UILabel.createLabel(text: "",
                                               properties: UILabelProperties(alignment: .center, color: .init(hex: Colors.green.rawValue), size: 40))
    }
    
    private func addCurrencyTypeTitleLabel() -> UIStackView {
        let props = UILabelProperties(alignment: .center, color: UIColor(hex: Colors.gray.rawValue), size: 20)
        let originTitle = UILabel.createLabel(text: Constants.sourceTitle.rawValue, properties: props)
        let targetTitle = UILabel.createLabel(text: Constants.targetTitle.rawValue, properties: props)
        
        let stackView = UIStackView(arrangedSubviews: [
            originTitle,
            targetTitle
        ])
        
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.setProperty(item: originTitle, value: 80, attribute: .width),
            NSLayoutConstraint.setProperty(item: targetTitle, value: 80, attribute: .width)
        ])
        
        return stackView
    }
    
    private func addButtonsAndImage() -> UIStackView {
        let imageView = UIImageView.createImageView(with: ImageName.arrow.rawValue)
        
        let stackView = UIStackView(arrangedSubviews: [
            fromCurrencyButton, imageView, targetCurrencyButton
        ])
        
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        NSLayoutConstraint.activate(NSLayoutConstraint.setSize(item: fromCurrencyButton!, width: 80, height: 80))
        NSLayoutConstraint.activate(NSLayoutConstraint.setSize(item: targetCurrencyButton!, width: 80, height: 80))
        NSLayoutConstraint.activate(NSLayoutConstraint.setSize(item: imageView, width: 32, height: 32))
        
        return stackView
    }
    
    private func addCurrenciesStack() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            addCurrencyTypeTitleLabel(),
            addButtonsAndImage(),
            UILabel.createLabel(text: Constants.selectCurrenciesHelper.rawValue,
                                properties: UILabelProperties(alignment: .center, color: UIColor.init(hex: Colors.gray.rawValue), size: 12))
        ])
        
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.axis = .vertical
        
        return stackView
    }
    
    private func addUpdateExchangeValue() -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: [
            updateExchangeButton,
            lastUpdateLabel,
        ])
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        
        return stackView
    }
    
    private func addTextField() -> UIStackView {
        let title = UILabel.createLabel(text: Constants.valueToConvertTitle.rawValue,
                                        properties: UILabelProperties(alignment: .center, color: .init(hex: Colors.gray.rawValue), size: 20))
        
        let stackView = UIStackView(arrangedSubviews: [title, textField, convertButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint.setProperty(item: textField!, value: 40, attribute: .height)
        ])
        
        return stackView
    }
    
    private func addConvertedValueView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [titleConversion, resultConversion])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        
        return stackView
    }
    
    private func handleConvertedValues() {
        titleConversion.text = viewModel.getConversionText()
        resultConversion.text = viewModel.getConvertedValueText()
    }
    
    private func addMainStackView() {
        stackView = UIStackView(arrangedSubviews: [
            addCurrenciesStack(),
            UIView(),
            addUpdateExchangeValue()
        ])
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        stackView.isLayoutMarginsRelativeArrangement = true
        view.addSubview(stackView)
        
        view.addConstraints(NSLayoutConstraint.setConstraintEqualParent(item: stackView!, parent: view.safeAreaLayoutGuide, margin: (top: 0, right: 0, bottom: 0, left: 0)))
    }
}

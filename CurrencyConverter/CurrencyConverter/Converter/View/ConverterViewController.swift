//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 29/10/20.
//

import UIKit

class ConverterViewController: UIViewController {

    private let viewModel: ConverterViewModel = ConverterViewModel()
    
    // MARK: - Layout Vars
    private lazy var originCurrencyButton: UIButton = {
        let button = UIButton().cornerRadius(Style.defaultRadius).useConstraint()
        button.addTarget(self, action: #selector(originList), for: .touchUpInside)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.setBackgroundColor(color: Style.veryDarkGray, forState: .normal)
        return button
    }()
    
    private lazy var targetCurrencyButton: UIButton = {
        let button = UIButton().cornerRadius(Style.defaultRadius).useConstraint()
        button.addTarget(self, action: #selector(targetList), for: .touchUpInside)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.setBackgroundColor(color: Style.veryDarkGray, forState: .normal)
        return button
    }()
    
    private lazy var converterView: CurrencyConverterView = {
        let converterView = CurrencyConverterView().cornerRadius(Style.defaultRadius).useConstraint()
        converterView.backgroundColor = Style.veryDarkGray
        converterView.delegate = self
        return converterView
    }() 
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        viewModel.delegate = self
    }
    
    // MARK: - Setups
    private func setupLayout() {
        view.backgroundColor = .black
        view.addSubview(originCurrencyButton)
        view.addSubview(targetCurrencyButton)
        view.addSubview(converterView)
        
        originCurrencyButton
            .top(anchor: view.safeAreaLayoutGuide.topAnchor)
            .leading(anchor: view.leadingAnchor, constant: Style.defaultLeading)
            .height(constant: Style.Home.currencyHeight)
            .width(anchor: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: Style.Home.widthOffset)
        
        targetCurrencyButton
            .top(anchor: view.safeAreaLayoutGuide.topAnchor)
            .trailing(anchor: view.trailingAnchor, constant: Style.defaultTrailing)
            .height(constant: Style.Home.currencyHeight)
            .width(anchor: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: Style.Home.widthOffset)
        
        converterView
            .top(anchor: targetCurrencyButton.bottomAnchor, constant: Style.defaultTop)
            .leading(anchor: view.leadingAnchor, constant: Style.defaultLeading)
            .trailing(anchor: view.trailingAnchor, constant: Style.defaultTrailing)
    }
    
    private func createAttributedString(code: String, name: String) -> NSMutableAttributedString {
        let titleAttributed: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: Style.defaultFont]
        let subtitleAttributed: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray, .font: Style.defaultFont]
        let string = NSMutableAttributedString(string: "\(code)\n", attributes: titleAttributed)
        string.append(NSAttributedString(string: "\(name)", attributes: subtitleAttributed))
        return string
    }
    
    // MARK: - Actions
    @objc private func originList() {
        let controller = ListViewController(type: .origin)
        controller.delegate = self
        present(UINavigationController(rootViewController: controller), animated: true)
    }
    
    @objc private func targetList() {
        let controller = ListViewController(type: .target)
        controller.delegate = self
        present(UINavigationController(rootViewController: controller), animated: true)
    }
}

// MARK: - ConverterView Delegate
extension ConverterViewController: CurrencyConverterViewDelegate {
    func textFormatting(_ text: String?) -> String {
        return viewModel.textValueFomatter(text)
    }
}

// MARK: - ViewModel
extension ConverterViewController: ConverterViewModelDelegate {
    func setOriginCurrency(_ currency: Currecy) {
        let title = createAttributedString(code: currency.code, name: currency.name)
        originCurrencyButton.setAttributedTitle(title, for: .normal)
        converterView.setupCurrency(currency, type: .origin)
    }
    
    func setTargetCurrency(_ currency: Currecy) {
        let title = createAttributedString(code: currency.code, name: currency.name)
        targetCurrencyButton.setAttributedTitle(title, for: .normal)
        converterView.setupCurrency(currency, type: .target)
    }
}

// MARK: - List Delegate
extension ConverterViewController: ListDelegate {
    func didSelectCurrency(_ currency: Currecy, type: CurrencyType) {
        viewModel.setCurrency(currency, type: type)
    }
}

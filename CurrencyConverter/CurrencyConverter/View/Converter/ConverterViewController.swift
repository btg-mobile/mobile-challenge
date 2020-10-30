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
        let button = UIButton().cornerRadius(8).useConstraint()
        button.addTarget(self, action: #selector(originList), for: .touchUpInside)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.setBackgroundColor(color: .darkGray, forState: .normal)
        button.setAttributedTitle(createAttributedString(code: "USB", name: "United State"), for: .normal)
        return button
    }()
    
    private lazy var targetCurrencyButton: UIButton = {
        let button = UIButton().cornerRadius(8).useConstraint()
        button.addTarget(self, action: #selector(targetList), for: .touchUpInside)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.setBackgroundColor(color: .darkGray, forState: .normal)
        button.setAttributedTitle(createAttributedString(code: "BRL", name: "Brazil"), for: .normal)
        return button
    }()
    
    private lazy var inputCurrencyValue: TextField = {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 12)]
        let textField = TextField().cornerRadius(8).useConstraint()
        textField.backgroundColor = .darkGray
        textField.attributedPlaceholder = NSAttributedString(string: "Currency value to convert", attributes: attributes)
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return textField
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
        view.addSubview(inputCurrencyValue)
        
        originCurrencyButton
            .top(anchor: view.safeAreaLayoutGuide.topAnchor, constant: 0)
            .leading(anchor: view.leadingAnchor, constant: 24)
            .height(constant: 50)
            .width(anchor: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: -36)
        
        targetCurrencyButton
            .top(anchor: view.safeAreaLayoutGuide.topAnchor, constant: 0)
            .trailing(anchor: view.trailingAnchor, constant: -24)
            .height(constant: 50)
            .width(anchor: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5, constant: -36)
        
        inputCurrencyValue
            .top(anchor: targetCurrencyButton.bottomAnchor, constant: 24)
            .leading(anchor: view.leadingAnchor, constant: 24)
            .trailing(anchor: view.trailingAnchor, constant: -24)
            .height(constant: 50)
    }
    
    private func createAttributedString(code: String, name: String) -> NSMutableAttributedString {
        let titleAttributed: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 12)]
        let subtitleAttributed: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 12)]
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

// MARK: - ViewModel
extension ConverterViewController: ConverterViewModelDelegate {
    func setOriginCurrency(_ currency: Currecy) {
        let title = createAttributedString(code: currency.code, name: currency.name)
        originCurrencyButton.setAttributedTitle(title, for: .normal)
    }
    
    func setTargetCurrency(_ currency: Currecy) {
        let title = createAttributedString(code: currency.code, name: currency.name)
        targetCurrencyButton.setAttributedTitle(title, for: .normal)
    }
}

// MARK: - List Delegate
extension ConverterViewController: ListDelegate {
    func didSelectCurrency(_ currency: Currecy, type: CurrencyType) {
        viewModel.setCurrency(currency, type: type)
    }
}

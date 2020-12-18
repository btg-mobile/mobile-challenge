//
//  CurrencyConverterViewController.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 14/12/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController, ViewCodable {
    @CurrencyTextField var originCurrencyTextField
    @CurrencyTextField var targetCurrencyTextField

    private weak var coordinator: CurrencyChoosing?
    private var viewModel: CurrencyConverterViewModel?

    init(coordinator: CurrencyChoosing) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setConstraints()
    }

    func setUp() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = LiteralText.currencyConverterViewControllerTitle

        originCurrencyTextField.delegate = self

        let service = CurrencyListService(network: APIClient.shared)
        viewModel = CurrencyConverterViewModel(service: service) { [weak self] in
            self?.updateUI()
        }
        updateUI()
    }

    func setConstraints() {
        view.addSubview(originCurrencyTextField)
        view.addSubview(targetCurrencyTextField)
        
        NSLayoutConstraint.activate([
            originCurrencyTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: DesignSystem.Spacing.leadingTopSafeArea),
            originCurrencyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DesignSystem.Spacing.leadingTopSafeArea),
            originCurrencyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: DesignSystem.Spacing.trailingBottomSafeArea),
            originCurrencyTextField.heightAnchor.constraint(equalToConstant: DesignSystem.TextField.height),

            targetCurrencyTextField.topAnchor.constraint(equalTo: originCurrencyTextField.bottomAnchor, constant: DesignSystem.Spacing.leadingTopSafeArea),
            targetCurrencyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DesignSystem.Spacing.leadingTopSafeArea),
            targetCurrencyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: DesignSystem.Spacing.trailingBottomSafeArea),
            targetCurrencyTextField.heightAnchor.constraint(equalToConstant: DesignSystem.TextField.height)
        ])
    }

    func updateUI() {
        guard let viewModel = viewModel else { return }
        _originCurrencyTextField.setCurrencyCode(viewModel.originCurrency.code)
        _targetCurrencyTextField.setCurrencyCode(viewModel.targetCurrency.code)
    }
}

extension CurrencyConverterViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        textField.text = viewModel!.getCurrencyValue(forText: textField.text!)
        return true
    }
}

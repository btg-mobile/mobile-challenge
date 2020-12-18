//
//  CurrencyConverterViewController.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 14/12/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController, ViewCodable {

    @DetailsButton(.origin) var originCurrencyButton
    @DetailsButton(.target) var targetCurrencyButton

    @CurrencyTextField(.origin) var originCurrencyTextField
    @CurrencyTextField(.target) var targetCurrencyTextField

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            originCurrencyButton,
            originCurrencyTextField,
            targetCurrencyButton,
            targetCurrencyTextField
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = DesignSystem.Spacing.min
        stackView.alignment = .fill

        return stackView
    }()

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
        view.backgroundColor = DesignSystem.Color.background
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = LiteralText.currencyConverterViewControllerTitle

        originCurrencyTextField.delegate = self
        targetCurrencyTextField.delegate = self

        _originCurrencyButton.onTouch = { [weak self] in
            self?.coordinator?.chooseCurrency { [weak self] currency in
                self?.viewModel?.setSelectedCurrency(currency, for: .origin)
            }
        }

        _targetCurrencyButton.onTouch = { [weak self] in
            self?.coordinator?.chooseCurrency { [weak self] currency in
                self?.viewModel?.setSelectedCurrency(currency, for: .target)
            }
        }

        let service = CurrencyListService(network: APIClient.shared)
        viewModel = CurrencyConverterViewModel(service: service) { [weak self] in
            self?.updateUI()
        }
        updateUI()
    }

    func setConstraints() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            originCurrencyButton.heightAnchor.constraint(equalToConstant: DesignSystem.TextField.height),
            targetCurrencyButton.heightAnchor.constraint(equalToConstant: DesignSystem.TextField.height),
            originCurrencyTextField.heightAnchor.constraint(equalToConstant: DesignSystem.TextField.height),
            targetCurrencyTextField.heightAnchor.constraint(equalToConstant: DesignSystem.TextField.height),

            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: DesignSystem.Spacing.leadingTopSafeArea),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: DesignSystem.Spacing.leadingTopSafeArea),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: DesignSystem.Spacing.trailingBottomSafeArea),
        ])
    }

    func updateUI() {
        guard let viewModel = viewModel else { return }
        _originCurrencyTextField.setCurrencyCode(viewModel.originCurrency.code)
        _targetCurrencyTextField.setCurrencyCode(viewModel.targetCurrency.code)

        _originCurrencyButton.setDetailsLabel(text: viewModel.originCurrency.name)
        _targetCurrencyButton.setDetailsLabel(text: viewModel.targetCurrency.name)
    }
}

extension CurrencyConverterViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        textField.text = viewModel!.getCurrencyValue(forText: textField.text!)
        return true
    }
}

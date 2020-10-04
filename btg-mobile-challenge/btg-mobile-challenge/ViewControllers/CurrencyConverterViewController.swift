//
//  CurrencyConverterViewController.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import UIKit

/// Representation of the app's conversion screen.
final class CurrencyConverterViewController: UIViewController {
    //- MARK: Properties
    // Amount
    @AutoLayout private var amountTextField: CurrencyTextField

    // From currency
    @AutoLayout private var fromCurrencyLabel: CurrencyLabel
    @AutoLayout private var fromCurrencyButton: CurrencyButton

    // To currency
    @AutoLayout private var toCurrencyLabel: CurrencyLabel
    @AutoLayout private var toCurrencyButton: CurrencyButton

    // Conversion result
    @AutoLayout private var conversionResultLabel: CurrencyResultLabel

    /// The `ViewModel` for this type.
    private let viewModel: CurrencyConverterViewModel

    //- MARK: Init
    /// Initializes a new instance of this type.
    /// - Parameter viewModel: The `ViewModel` for this type.
    init(viewModel: CurrencyConverterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //- MARK: Life cycle
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        title = "Converter"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
        setUpViews()
        layoutConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fromCurrencyButton.setTitle(viewModel.fromCurrency, for: .normal)
        toCurrencyButton.setTitle(viewModel.toCurrency, for: .normal)
        amountTextField.text = ""
        conversionResultLabel.text = ""
        viewModel.fetch()
    }

    // - MARK: @objc
    @objc private func amountDidChange() {
        guard let newAmount = amountTextField.text,
              newAmount != viewModel.amount else {
            return
        }

        viewModel.amount = newAmount
    }

    @objc private func pickFromCurrency() {
        viewModel.pickCurrency(.from)
    }

    @objc private func pickToCurrency() {
        viewModel.pickCurrency(.to)
    }

    @objc private func openList() {
        viewModel.listCurrencies()
    }

    @objc private func refreshData() {
        viewModel.refresh()
    }

    // - MARK: ViewModel setup
    private func setUpViewModel() {
        viewModel.fetch()
        viewModel.delegate = self
    }

    //- MARK: Views setup

    private func setUpViews() {
        setUpNavigationItem()
        setUpFromCurrency()
        setUpToCurrency()
        setUpAmountTextField()
    }

    private func setUpFromCurrency() {
        fromCurrencyButton.addTarget(self, action: #selector(pickFromCurrency), for: .touchUpInside)
        fromCurrencyLabel.text = "From"
    }

    private func setUpToCurrency() {
        toCurrencyButton.addTarget(self, action: #selector(pickToCurrency), for: .touchUpInside)
        toCurrencyLabel.text = "To"
    }

    private func setUpAmountTextField() {
        amountTextField.placeholder = "Amount to be converted"
        amountTextField.addTarget(self, action: #selector(amountDidChange), for: .editingChanged)
    }

    private func setUpNavigationItem() {
        let listButton = UIBarButtonItem(barButtonSystemItem: .bookmarks,
                                         target: self,
                                         action: #selector(openList))
        navigationItem.rightBarButtonItem = listButton

        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh,
                                            target: self,
                                            action: #selector(refreshData))
        navigationItem.leftBarButtonItem = refreshButton
    }

    //- MARK: Layout
    private func layoutConstraints() {
        layoutFromCurrency()
        layoutToCurreny()
        layoutAmountTextField()
        layoutResultLabel()

    }

    private func layoutFromCurrency() {
        view.addSubview(fromCurrencyButton)
        view.addSubview(fromCurrencyLabel)

        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            fromCurrencyButton.centerYAnchor.constraint(equalTo: layoutGuides.centerYAnchor),
            fromCurrencyButton.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            fromCurrencyButton.heightAnchor.constraint(equalToConstant: DesignSpec.Button.height),
            fromCurrencyButton.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor,
                                                      multiplier: DesignSpec.Button.widthMultiplier),

            fromCurrencyLabel.bottomAnchor.constraint(equalTo: fromCurrencyButton.topAnchor,
                                                      constant: -DesignSpec.Spacing.default),
            fromCurrencyLabel.centerXAnchor.constraint(equalTo: fromCurrencyButton.centerXAnchor),
            fromCurrencyLabel.widthAnchor.constraint(equalTo: fromCurrencyButton.widthAnchor),
            fromCurrencyLabel.heightAnchor.constraint(equalToConstant: DesignSpec.Label.height)
        ])
    }

    private func layoutToCurreny() {
        view.addSubview(toCurrencyButton)
        view.addSubview(toCurrencyLabel)

        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            toCurrencyButton.centerYAnchor.constraint(equalTo: layoutGuides.centerYAnchor),
            toCurrencyButton.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            toCurrencyButton.heightAnchor.constraint(equalToConstant: DesignSpec.Button.height),
            toCurrencyButton.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor,
                                                    multiplier: DesignSpec.Button.widthMultiplier),

            toCurrencyLabel.bottomAnchor.constraint(equalTo: toCurrencyButton.topAnchor,
                                                    constant: -DesignSpec.Spacing.default),
            toCurrencyLabel.centerXAnchor.constraint(equalTo: toCurrencyButton.centerXAnchor),
            toCurrencyLabel.widthAnchor.constraint(equalTo: toCurrencyLabel.widthAnchor),
            toCurrencyLabel.heightAnchor.constraint(equalToConstant: DesignSpec.Label.height)
        ])
    }

    private func layoutAmountTextField() {
        view.addSubview(amountTextField)

        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            amountTextField.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor),
            amountTextField.heightAnchor.constraint(equalToConstant: DesignSpec.TextField.height),
            amountTextField.bottomAnchor.constraint(equalTo: fromCurrencyLabel.topAnchor,
                                                    constant: -DesignSpec.Spacing.medium),
            amountTextField.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor)
        ])
    }

    private func layoutResultLabel() {
        view.addSubview(conversionResultLabel)

        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            conversionResultLabel.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor,
                                                         multiplier: DesignSpec.Result.widthMultiplier),
            conversionResultLabel.heightAnchor.constraint(equalToConstant: DesignSpec.Result.height),
            conversionResultLabel.bottomAnchor.constraint(equalTo: amountTextField.topAnchor,
                                                          constant: -DesignSpec.Spacing.large),
            conversionResultLabel.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor)
        ])
    }
}

// - MARK: ViewModel delegate
extension CurrencyConverterViewController: CurrencyConverterViewModelDelegate {
    func updateUI() {
        conversionResultLabel.text = viewModel.convertedAmount
    }
}

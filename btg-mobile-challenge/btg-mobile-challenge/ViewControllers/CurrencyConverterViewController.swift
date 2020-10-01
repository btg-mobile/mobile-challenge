//
//  CurrencyConverterViewController.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import UIKit

final class CurrencyConverterViewController: UIViewController {
    //- MARK: Properties

    // Amount UITextField
    private lazy var amountTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Amount to be converted"
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        return textField
    }()

    // From currency UILabel and UIButton
    private lazy var fromCurrencyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "From"
        label.textAlignment = .center
        return label
    }()

    private lazy var fromCurrencyButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("USD", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.layer.cornerRadius = DesignSpec.Button.cornerRadius
        button.clipsToBounds = true
        button.backgroundColor = .systemRed
        return button
    }()

    // To currency UILabel and UIButton
    private lazy var toCurrencyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "To"
        label.textAlignment = .center
        return label
    }()

    private lazy var toCurrencyButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("BRL", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = DesignSpec.Button.cornerRadius
        button.clipsToBounds = true
        return button
    }()

    // Conversion result UILabel
    private lazy var conversionResultLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5.47"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    //- MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //- MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutConstraints()
    }

    private func layoutConstraints() {
        view.addSubview(amountTextField)

        view.addSubview(fromCurrencyButton)
        view.addSubview(fromCurrencyLabel)

        view.addSubview(toCurrencyButton)
        view.addSubview(toCurrencyLabel)

        view.addSubview(conversionResultLabel)

        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            //From currency UILabel and UIButton constraints
            fromCurrencyButton.centerYAnchor.constraint(equalTo: layoutGuides.centerYAnchor),
            fromCurrencyButton.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            fromCurrencyButton.heightAnchor.constraint(equalToConstant: DesignSpec.Button.height),
            fromCurrencyButton.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor,
                                                      multiplier: DesignSpec.Button.widthMultiplier),

            fromCurrencyLabel.bottomAnchor.constraint(equalTo: fromCurrencyButton.topAnchor,
                                                      constant: -DesignSpec.Spacing.default),
            fromCurrencyLabel.centerXAnchor.constraint(equalTo: fromCurrencyButton.centerXAnchor),
            fromCurrencyLabel.widthAnchor.constraint(equalTo: fromCurrencyButton.widthAnchor),
            fromCurrencyLabel.heightAnchor.constraint(equalToConstant: DesignSpec.Label.height),

            //To currency UILabel and UIButton constraints
            toCurrencyButton.centerYAnchor.constraint(equalTo: layoutGuides.centerYAnchor),
            toCurrencyButton.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            toCurrencyButton.heightAnchor.constraint(equalToConstant: DesignSpec.Button.height),
            toCurrencyButton.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor,
                                                    multiplier: DesignSpec.Button.widthMultiplier),

            toCurrencyLabel.bottomAnchor.constraint(equalTo: toCurrencyButton.topAnchor,
                                                    constant: -DesignSpec.Spacing.default),
            toCurrencyLabel.centerXAnchor.constraint(equalTo: toCurrencyButton.centerXAnchor),
            toCurrencyLabel.widthAnchor.constraint(equalTo: toCurrencyLabel.widthAnchor),
            toCurrencyLabel.heightAnchor.constraint(equalToConstant: DesignSpec.Label.height),

            //Amount UITextField constraints
            amountTextField.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor),
            amountTextField.heightAnchor.constraint(equalToConstant: DesignSpec.TextField.height),
            amountTextField.bottomAnchor.constraint(equalTo: fromCurrencyLabel.topAnchor,
                                                    constant: -DesignSpec.Spacing.medium),
            amountTextField.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor),

            //Conversion result UILabel constraints
            conversionResultLabel.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor,
                                                         multiplier: DesignSpec.Result.widthMultiplier),
            conversionResultLabel.heightAnchor.constraint(equalToConstant: DesignSpec.Result.height),
            conversionResultLabel.bottomAnchor.constraint(equalTo: amountTextField.topAnchor,
                                                          constant: -DesignSpec.Spacing.large),
            conversionResultLabel.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor)
        ])
    }


}


//
//  CurrencyConverterViewController.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    @AutoLayout private var currencyButton: SupportedButton
    
    @AutoLayout private var fromCurrencyLabel: CurrencyResultLabel
    @AutoLayout private var fromCurrencyButton: CurrentyButton
    
    @AutoLayout private var toCurrencyLabel: CurrencyResultLabel
    @AutoLayout private var toCurrencyButton: CurrentyButton
    
    private lazy var keyboard: KeyboardView = KeyboardView(frame: self.view.frame, delegate: self)

    private var viewModel: CurrencyConverterViewModel
    
    init(viewModel: CurrencyConverterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        layoutConstraints()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    //MARK: - SetUp
    private func setUpViews() {
        setUpButton()
        setUpFromCurrentyButton()
        setUpToCurrentyButton()
        setUpKeyboard()
    }
    
    private func layoutConstraints() {
        layoutButton()
        layoutFromCurrenty()
        layoutToCurrenty()
        layoutToKeyboard()
    }
    //MARK: - End SetUp
    
    //MARK: - Views setUp
    private func setUpButton() {
        currencyButton.addTarget(self, action: #selector(openList),
                                 for: .touchUpInside)
    }
    
    private func setUpFromCurrentyButton() {
        fromCurrencyButton.addTarget(self, action: #selector(openList),
                                     for: .touchUpInside)
    }
    
    private func setUpToCurrentyButton() {
        toCurrencyButton.addTarget(self, action: #selector(openList),
                                   for: .touchUpInside)
    }
    
    private func setUpKeyboard() {
        keyboard.delegate = keyboard
        keyboard.dataSource = keyboard
    }
    
    //MARK: - objcs
    @objc private func openList() {
        viewModel.pickSupporteds()
    }
    //MARK: - End objcs
    
    //MARK: - Layout
    private func layoutButton() {
        view.addSubview(currencyButton)
        
        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            currencyButton.topAnchor.constraint(equalTo: layoutGuides.topAnchor, constant: DesignSystem.Spacing.large),
            currencyButton.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            currencyButton.heightAnchor.constraint(equalToConstant: DesignSystem.Button.height),
            currencyButton.widthAnchor.constraint(equalToConstant: DesignSystem.Button.width)
        ])
    }
    
    private func layoutFromCurrenty() {
        view.addSubview(fromCurrencyLabel)
        view.addSubview(fromCurrencyButton)
        
        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            fromCurrencyButton.topAnchor.constraint(equalTo: currencyButton.bottomAnchor, constant: DesignSystem.Spacing.large),
            fromCurrencyButton.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            fromCurrencyButton.heightAnchor.constraint(equalToConstant: DesignSystem.Button.Currency.height),
            fromCurrencyButton.widthAnchor.constraint(equalToConstant: DesignSystem.Button.Currency.width),
            
            
            fromCurrencyLabel.topAnchor.constraint(equalTo: fromCurrencyButton.topAnchor),
            fromCurrencyLabel.trailingAnchor.constraint(equalTo: fromCurrencyButton.leadingAnchor),
            fromCurrencyLabel.heightAnchor.constraint(equalToConstant: DesignSystem.Button.Currency.height),
            fromCurrencyLabel.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor, multiplier: DesignSystem.Button.Currency.widthMultiplier),
        ])
    }
    
    private func layoutToCurrenty() {
        view.addSubview(toCurrencyLabel)
        view.addSubview(toCurrencyButton)
        
        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            toCurrencyButton.topAnchor.constraint(equalTo: fromCurrencyButton.bottomAnchor),
            toCurrencyButton.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            toCurrencyButton.heightAnchor.constraint(equalToConstant: DesignSystem.Button.Currency.height),
            toCurrencyButton.widthAnchor.constraint(equalToConstant: DesignSystem.Button.Currency.width),
            
            
            toCurrencyLabel.topAnchor.constraint(equalTo: toCurrencyButton.topAnchor),
            toCurrencyLabel.trailingAnchor.constraint(equalTo: toCurrencyButton.leadingAnchor),
            toCurrencyLabel.heightAnchor.constraint(equalToConstant: DesignSystem.Button.Currency.height),
            toCurrencyLabel.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor, multiplier: DesignSystem.Button.Currency.widthMultiplier),
        ])
    }
    
    private func layoutToKeyboard() {
        view.addSubview(keyboard)
        
        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            keyboard.topAnchor.constraint(equalTo: toCurrencyButton.bottomAnchor,
                                          constant: DesignSystem.Spacing.large*4),
            keyboard.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor),
            keyboard.heightAnchor.constraint(equalToConstant: DesignSystem.Keyboard.height),
            keyboard.widthAnchor.constraint(equalToConstant: DesignSystem.Keyboard.width),
        ])
    }
    //MARK: - End Layout
}

extension CurrencyConverterViewController: KeyboardViewService {
    func selected(value: Int) {
        debugPrint(value)
    }
}


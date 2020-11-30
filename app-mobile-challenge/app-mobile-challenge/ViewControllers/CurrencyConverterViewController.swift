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
    
    @AutoLayout private var calculationButton: CalculationButton

    private lazy var keyboard: KeyboardView = KeyboardView(frame: self.view.frame, delegate: self)

    private var viewModel: CurrencyConverterViewModel
    
    /// Define a primeira entrada no app para não chamar a função de calculo
    private var firstMoment: Bool = true
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !firstMoment { updateCurrencyView() }
        firstMoment = false
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
        setUpToCalculationButton()
    }
    
    private func layoutConstraints() {
        layoutButton()
        layoutFromCurrenty()
        layoutToCurrenty()
        layoutCalculationButton()
        layoutToKeyboard()
    }
    //MARK: - SetUp fim
    
    //MARK: - Views setUp
    private func setUpButton() {
        currencyButton.addTarget(self, action: #selector(openList),
                                 for: .touchUpInside)
    }
    
    private func setUpFromCurrentyButton() {
        fromCurrencyButton.addTarget(self,
                                     action: #selector(fromPickList),
                                     for: .touchUpInside)
    }
    
    private func setUpToCurrentyButton() {
        toCurrencyButton.addTarget(self,
                                   action: #selector(toPickList),
                                   for: .touchUpInside)
    }
    
    private func setUpToCalculationButton() {
        calculationButton.addTarget(self,
                                    action: #selector(calculate),
                                    for: .touchUpInside)
    }
    private func updateCurrencyView() {
        calculate()
        fromCurrencyButton.setTitle(viewModel.fromCurrency, for: .normal)
        toCurrencyButton.setTitle(viewModel.toCurrency, for: .normal)
    }
    
    //MARK: - objcs
    @objc private func openList() {
        viewModel.openSupporteds()
    }
    @objc private func fromPickList() {
        viewModel.pickSupporteds(type: .from)
    }
    @objc private func toPickList() {
        viewModel.pickSupporteds(type: .to)
    }
    @objc private func calculate() {
        guard let values = viewModel.calculateConvertion().0 else {
            if let error = viewModel.calculateConvertion().1 {
                self.showAlert("Ops...", error) { }
                return
            }
            self.showAlert("Algo inesperado aconteceu na conversão") { }
            return
        }
        viewModel.currencyValue = values.valueFrom
        fromCurrencyLabel.text = values.valueFrom == "" ? "1,00" : values.valueFrom
        
        toCurrencyLabel.text =  values.valueFrom == "" ? "1,00" : values.valueTo
    }
    //MARK: - objcs fim
    
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
            fromCurrencyLabel.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor, multiplier: DesignSystem.Button.Currency.widthLabelMultiplier),
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
            toCurrencyLabel.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor, multiplier: DesignSystem.Button.Currency.widthLabelMultiplier),
        ])
    }
    
    private func layoutToKeyboard() {
        view.addSubview(keyboard)
        let layoutGuides = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            keyboard.bottomAnchor.constraint(
                equalTo: calculationButton.topAnchor, constant: -DesignSystem.Spacing.default*(view.frame.height-568)*0.02),
            keyboard.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor),
            keyboard.heightAnchor.constraint(equalToConstant: DesignSystem.Keyboard.height),
            keyboard.widthAnchor.constraint(equalToConstant: DesignSystem.Keyboard.width),
        ])
    }
    
    private func layoutCalculationButton() {
        view.addSubview(calculationButton)
        
        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            calculationButton.bottomAnchor.constraint(
                equalTo: layoutGuides.bottomAnchor,
                constant: DesignSystem.Keyboard.Layout.top),
            calculationButton.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor),
            calculationButton.heightAnchor.constraint(equalToConstant: DesignSystem.Keyboard.Layout.height),
            calculationButton.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor, multiplier: DesignSystem.Keyboard.Layout.widthMultiplier),
        ])
    }
    //MARK: - Layout fim
}

//MARK: - Integração com Keyboard
extension CurrencyConverterViewController: KeyboardViewService {
    func selected(value: String) {
        fromCurrencyLabel.text = value
        viewModel.currencyValue = value
        if(viewModel.currencyValueIsEmpty()) {
            fromCurrencyLabel.text = "1,00"
        }
    }
}

//
//  CurrencyConverterViewController.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    // MARK: View Model
    private let currencyConverter = CurrencyConverterViewModel()
    
    // MARK: UI Elements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        return scrollView
    }()
    private let contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let buttonsStack: UIStackView = {
        let buttonsStack = UIStackView(frame: .zero)
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.backgroundColor = .clear
        buttonsStack.axis = .horizontal
        buttonsStack.alignment = .center
        buttonsStack.distribution = .fill
        return buttonsStack
    }()
    
    private let originButtonStack: UIStackView = UIStackView(frame: .zero)
    private let originCurrencyButton: UIButton = UIButton(frame: .zero)
    
    private let destinyButtonStack: UIStackView = UIStackView(frame: .zero)
    private let destinyCurrencyButton: UIButton = UIButton(frame: .zero)
    
    private let textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 32, weight: .heavy)
        textField.textColor = .systemGray
        textField.keyboardType = .decimalPad
        textField.placeholder = "Entre com o valor"
        return textField
    }()
    
    private let convertedCurrencyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.backgroundColor = .systemGray6
        label.textColor = .systemGray
        return label
    }()
    
    private let lastUpdateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .center
        label.textColor = .systemGray6
        label.text = "Última atualização em: --"
        return label
    }()
    
    // MARK: Delegates
    private let textFieldDelegate: InputCurrencyTextFieldDelegate = InputCurrencyTextFieldDelegate()
    
    // MARK: Others
    private var originCurrency: String = "BRL"
    private var destinyCurrency: String = "AUD"
    
    deinit {
        removeObservers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyConverter.getQuotes()
        
        setupAutoScrollWhenKeyboardShowsUp()
        setupBindings()
        setupUI()
    }
    
    // MARK: Setup methods
    private func setupBindings() {
        currencyConverter.quotesFetched = {
            self.updateData()
        }
    }
    
    private func updateData() {
        
        guard let lastUpdate = currencyConverter.quotes?.lastUpdate.gmtToCurrent(dateFormat: "dd/MM/yyyy HH:mm") else {
            lastUpdateLabel.text = ""
            return
        }
        
        DispatchQueue.main.async {
            self.lastUpdateLabel.text = "Última atualização em: \(String(describing: lastUpdate))"
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        setupScrollView()
        setupButtons()
        setupInputField()
        setupConvertedCurrencyLabel()
        setupLastUpdateLabel()
    }
    
    private func setupScrollView() {
        // Add scrollView as subview of view
        view.addSubview(scrollView)
        
        // Setup scrollView constraints
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        // Add contentView as subview of scrollView
        scrollView.addSubview(contentView)
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
    private func setupButtons() {
        // Add ButtonsStack as subview of scrollView
        contentView.addSubview(buttonsStack)
        
        // Setup buttonsStack constraints
        buttonsStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -100).isActive = true
        buttonsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        buttonsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        
        // Setup origin button
        setupSingleButton(label: "Origem:", stack: originButtonStack, button: originCurrencyButton, buttonTitle: originCurrency)
        
        // Setup center arrow
        let arrow = UILabel()
        arrow.text = "->"
        arrow.font = .boldSystemFont(ofSize: 36)
        arrow.adjustsFontSizeToFitWidth = true
        arrow.textAlignment = .center
        arrow.textColor = .white
        
        // Add arrow as subview of buttonsStack
        buttonsStack.addArrangedSubview(arrow)
        
        // Setup destiny button
        setupSingleButton(label: "Destino:", stack: destinyButtonStack, button: destinyCurrencyButton, buttonTitle: destinyCurrency)
    }
    
    private func setupSingleButton(label: String, stack: UIStackView, button: UIButton, buttonTitle: String) {
        // Setup stack attributes
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .clear
        stack.axis = .vertical
        stack.spacing = 5
        
        // Add stack as subview of buttonsStack
        buttonsStack.addArrangedSubview(stack)
        
        // Setup upperLabel
        let upperLabel = UILabel()
        upperLabel.text = label
        upperLabel.textColor = .systemGray6
        
        // Add upperLabel as subview of stack
        stack.addArrangedSubview(upperLabel)
        
        // Setup button
        button.setTitle(buttonTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = .systemGray6
        button.setTitleColor(.systemGray, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(currencyButtonTapped(_:)), for: .touchUpInside)
        
        // Add button as subview of stack
        stack.addArrangedSubview(button)
        
        // Setup button constraints
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupInputField() {
        // Setup textField delegate
        textField.delegate = textFieldDelegate
        textFieldDelegate.textChanged = {
            self.inputTextChanged()
        }
        
        // Add textField as subview of view
        contentView.addSubview(textField)
        
        // Setup textField constraints
        textField.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 30).isActive = true
        textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func setupConvertedCurrencyLabel() {
        // Add convertedCurrencyLabel as subview of view
        contentView.addSubview(convertedCurrencyLabel)
        
        // Setup convertedCurrencyLabel constraints
        convertedCurrencyLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30).isActive = true
        convertedCurrencyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        convertedCurrencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        convertedCurrencyLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    private func setupLastUpdateLabel() {
        // Add lastUpdateLabel as subview of view
        contentView.addSubview(lastUpdateLabel)
        
        // Setup lastUpdateLabel constraints
        lastUpdateLabel.topAnchor.constraint(equalTo: convertedCurrencyLabel.bottomAnchor, constant: 30).isActive = true
        lastUpdateLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        lastUpdateLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
    }
    
    private func inputTextChanged() {
        
        guard var inputText = textField.text else {
            textField.text = ""
            convertedCurrencyLabel.text = ""
            return
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.positiveInfinitySymbol = "Valor inválido"
        numberFormatter.alwaysShowsDecimalSeparator = false
        numberFormatter.currencyCode = originCurrency
        numberFormatter.decimalSeparator = Locale.current.decimalSeparator
        numberFormatter.groupingSeparator = Locale.current.groupingSeparator
        // Enable separator input
        numberFormatter.alwaysShowsDecimalSeparator = inputText.last?.description == Locale.current.decimalSeparator ? true : false
        // Enable decimal character for 0 digit
        let splitString = inputText.split(separator: Character(Locale.current.decimalSeparator ?? ""))
        numberFormatter.minimumFractionDigits = splitString.count > 1 && splitString[1].last?.description == "0" ? 1 : 0
        
        // Remove every non digit character except decimal separator
        inputText.removeAll(where: {Double($0.description) == nil && $0.description != Locale.current.decimalSeparator})
        inputText = inputText.replacingOccurrences(of: Locale.current.decimalSeparator ?? "", with: ".")
                        
        // Deal with the case where textField has a currency and when it has only numbers
        if let originValue = Double(inputText),
           let valueConverted = currencyConverter.convert(originValue, from: originCurrency, to: destinyCurrency) {
            
            numberFormatter.currencyCode = originCurrency
            textField.text = numberFormatter.string(from: originValue as NSNumber)
            
            numberFormatter.currencyCode = destinyCurrency
            convertedCurrencyLabel.text = numberFormatter.string(from: valueConverted as NSNumber)
            
        } else {
            convertedCurrencyLabel.text = textField.hasText ? "Valor inválido" : ""
            textField.text = ""
        }
    }
    
    // MARK: Button target method
    @objc private func currencyButtonTapped(_ sender: UIButton) {
        print(sender)
    }
    
    // MARK: ScrollView behaviour
    override func setScrollViewContentInset(_ inset: UIEdgeInsets) {
        // Adjust the scrollView so the textField and the label doesn't hide when keyboard appears
        scrollView.contentInset = inset
        scrollView.contentSize = contentView.bounds.size
        
        let distanceLabelBottom = scrollView.contentSize.height - convertedCurrencyLabel.frame.origin.y
        let offsetY = inset.bottom == 0 ? 0 : scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom - distanceLabelBottom + convertedCurrencyLabel.bounds.height + 30
        scrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
    }
}

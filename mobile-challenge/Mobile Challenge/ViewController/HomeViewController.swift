//
//  ViewController.swift
//  Mobile Challenge
//
//  Created by Vinicius Serpa on 14/11/24.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    private let currencyVM = CurrencyViewModel()
    private let conversionVM = ConversionViewModel()
    let currencyListVC = CurrencyListViewController()
    
    var firstCurrencyValue: Float = 5.342801
    var secondCurrencyValue: Float = 1
    
    //MARK: View Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultlabel.text = "\(calculateConversion())"
    }
    
    
    
    //MARK: Label Components
    private let primaryCurrencyLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 32 , weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let secondaryCurrencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 24 , weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let resultlabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 32 , weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: Button Components
    private let  primaryCurrencyButton: UIButton = {
        let button = UIButton()
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 30)]
        
        let attributedTitle = NSAttributedString(string: "BRL", attributes: attributes)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let secondaryCurrencyButton: UIButton = {
        
        let button = UIButton()
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 30)]
        let attributedTitle = NSAttributedString(string: "USD", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    //MARK: TextField Component
    private let amountTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Amount"
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 48 , weight: .medium)
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    //MARK: Image Components
    private let arrowImage: UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.forward")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .white
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    
    //MARK: View Configuration
    private func setup() {
        
        self.view.backgroundColor = .darkBlue
        self.view.addSubview(primaryCurrencyButton)
        self.view.addSubview(secondaryCurrencyButton)
        self.view.addSubview(primaryCurrencyLabel)
        self.view.addSubview(secondaryCurrencyLabel)
        self.view.addSubview(amountTextField)
        self.view.addSubview(resultlabel)
        self.view.addSubview(arrowImage)
        
        amountTextField.delegate = self
        amountTextField.inputAccessoryView = createToolbar()
        
        conversionVM.fetchConvertions()
        
        primaryCurrencyLabel.text = "BRL"
        secondaryCurrencyLabel.text = "USD"
        
        primaryCurrencyButton.addTarget(self, action: #selector(choosePrimaryCurrency), for: .touchUpInside)
        secondaryCurrencyButton.addTarget(self, action: #selector(chooseSecondaryCurrency), for: .touchUpInside)

        setupConstraints()
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([button], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
        
    }
    
    
    //MARK: Constraints
    private func setupConstraints() {
        
        
        NSLayoutConstraint.activate([
            
            arrowImage.widthAnchor.constraint(equalToConstant: 50),
            arrowImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arrowImage.centerYAnchor.constraint(equalTo: primaryCurrencyButton.centerYAnchor),
            
            primaryCurrencyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            primaryCurrencyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250),
            
            secondaryCurrencyButton.centerXAnchor.constraint(equalTo: primaryCurrencyButton.centerXAnchor, constant: 200),
            secondaryCurrencyButton.topAnchor.constraint(equalTo: primaryCurrencyButton.centerYAnchor, constant: -25),
            
            primaryCurrencyLabel.centerXAnchor.constraint(equalTo: primaryCurrencyButton.centerXAnchor, constant: 5),
            primaryCurrencyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -5),
            
            secondaryCurrencyLabel.centerXAnchor.constraint(equalTo: primaryCurrencyLabel.centerXAnchor, constant: -7),
            secondaryCurrencyLabel.centerYAnchor.constraint(equalTo: primaryCurrencyLabel.bottomAnchor, constant: 50),
            
            amountTextField.leftAnchor.constraint(equalTo: primaryCurrencyLabel.rightAnchor, constant: 30),
            amountTextField.centerYAnchor.constraint(equalTo: primaryCurrencyLabel.centerYAnchor, constant: -5),
            
            resultlabel.leftAnchor.constraint(equalTo: secondaryCurrencyLabel.rightAnchor, constant: 20),
            resultlabel.centerYAnchor.constraint(equalTo: secondaryCurrencyLabel.centerYAnchor, constant: -2)
        ])
        
    }
    
    //MARK: Calculate Conversion
    
    func calculateConversion() -> Float {
        
        guard let amountText = amountTextField.text, let amount = Float(amountText) else {return 0.0}
        
        let firstDollarValue = amount / firstCurrencyValue
        let conversion = firstDollarValue * secondCurrencyValue
        resultlabel.text = "\(conversion)"
        
        return conversion
    }
    
    //MARK: TextField Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        calculateConversion()
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        calculateConversion()
    }
    
    //MARK: Button Functions
    @objc private func choosePrimaryCurrency() {
        currencyListVC.isPrimarySelection = true
        
        currencyListVC.onCurrencySelected = { [weak self] code, value in
            guard let self = self else { return }
            
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 30)]
            let attributedTitle = NSAttributedString(string: code, attributes: attributes)
            self.primaryCurrencyButton.setAttributedTitle(attributedTitle, for: .normal)
            
            self.primaryCurrencyLabel.text = code
            self.firstCurrencyValue = value
            
        }
        navigationController?.pushViewController(currencyListVC, animated: true)
    }
    
    @objc private func chooseSecondaryCurrency() {
        currencyListVC.isPrimarySelection = false
        currencyListVC.onCurrencySelected = { [weak self] code, value in
            guard let self = self else { return }
            
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 30)]
            let attributedTitle = NSAttributedString(string: code, attributes: attributes)
            self.secondaryCurrencyButton.setAttributedTitle(attributedTitle, for: .normal)
            
            self.secondaryCurrencyLabel.text = code
            self.secondCurrencyValue = value
            
        }
        navigationController?.pushViewController(currencyListVC, animated: true)
    }
    
    //MARK: Keyboard Button Function
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

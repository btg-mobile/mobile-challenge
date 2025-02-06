//
//  ConversionViewController.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import UIKit

class ConversionViewController: UIViewController, CurrencyCellDelegate, UITextFieldDelegate {
    
    func didSelectCurrency(currency: String) {
        if selectedCurrencyType == .source {
            buttonSourceCurrency.setTitle(currency, for: .normal)
            currencySource = currency
        } else if selectedCurrencyType == .destination {
            buttonDestinationCurrency.setTitle(currency, for: .normal)
            currencyDestionation = currency
        }
        dismiss(animated: true)
    }

    
    var currencyViewModel: CurrencyViewModel
    var conversionViewModel: ConversionViewModel
    var selectedCurrencyType: CurrencyType?
    var convertedValue: Double = 0{
        didSet {
            updateConversion()
        }
    }
    
    var currencySource: String = "USD"
    var currencyDestionation: String = "BRL"
    
    init(currencyViewModel: CurrencyViewModel, conversionViewModel: ConversionViewModel) {
        self.currencyViewModel = currencyViewModel
        self.conversionViewModel = conversionViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .blue
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let buttonSourceCurrency: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "aaaaa"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let buttonDestinationCurrency: UIButton = {
        let button = UIButton()
        button.setTitle("tchau", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false


        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await fetchConversionData()
        }
        self.view.backgroundColor = .white
        setElements()

        // Do any additional setup after loading the view.
    }
    
    
    func fetchConversionData() async {
        do {
            let data = try await conversionViewModel.getConversionsData()
            DispatchQueue.main.async { [weak self] in
                self?.conversionViewModel.conversion = data
            }
        } catch ServiceError.invalidData{
            print("Error type data")
        } catch ServiceError.invalidResponse {
            print("Error type response")
        } catch ServiceError.invalidURL {
            print("Error type URL")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setElements() {
        self.view.addSubview(textField)
        textField.delegate = self
        textField.keyboardType = .numberPad
        addDoneButtonToKeyboard(textField: textField)

        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            textField.topAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        
        self.view.addSubview(buttonSourceCurrency)
        buttonSourceCurrency.addTarget(self, action: #selector(showSourceSheet), for: .touchUpInside)
        buttonSourceCurrency.setTitle(currencySource, for: .normal)

        
        NSLayoutConstraint.activate([
            buttonSourceCurrency.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            buttonSourceCurrency.topAnchor.constraint(equalTo: textField.topAnchor)
        ])
        
        
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 32)
        ])
        
        self.view.addSubview(buttonDestinationCurrency)
        buttonDestinationCurrency.addTarget(self, action: #selector(showDestinationSheet), for: .touchUpInside)
        buttonDestinationCurrency.setTitle(currencyDestionation, for: .normal)
        
        NSLayoutConstraint.activate([
            buttonDestinationCurrency.trailingAnchor.constraint(equalTo: buttonSourceCurrency.trailingAnchor),
            buttonDestinationCurrency.topAnchor.constraint(equalTo: label.topAnchor)
        ])
        
        
    }
    
    
    @objc func showSourceSheet() {
        let sheetViewController = CurrencyViewController(currencyViewModel: currencyViewModel)
        selectedCurrencyType = .source
        sheetViewController.modalPresentationStyle = .pageSheet
        sheetViewController.currencyCellDelegate = self
        present(sheetViewController, animated: true)
    }
    
    @objc func showDestinationSheet() {
        let sheetViewController = CurrencyViewController(currencyViewModel: currencyViewModel)
        selectedCurrencyType = .destination
        sheetViewController.modalPresentationStyle = .pageSheet
        sheetViewController.currencyCellDelegate = self
        present(sheetViewController, animated: true)
    }
    
    
    func updateConversion() {
        label.text = String(convertedValue)
    }
    
    func addDoneButtonToKeyboard(textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))

        toolbar.items = [flexSpace, doneButton]
        textField.inputAccessoryView = toolbar
    }

    @objc func doneButtonTapped() {
        convertedValue = conversionViewModel.converterMoeda(value: textField.text ?? "10", currencySource: currencySource, currencyDestination: currencyDestionation)
        view.endEditing(true)

    }

}






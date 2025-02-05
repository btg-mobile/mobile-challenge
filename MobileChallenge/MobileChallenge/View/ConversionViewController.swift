//
//  ConversionViewController.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import UIKit

class ConversionViewController: UIViewController {
    
    var currencyViewModel: CurrencyViewModel
    
    init(currencyViewModel: CurrencyViewModel) {
        self.currencyViewModel = currencyViewModel
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
        button.setTitle("oi", for: .normal)
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
        
        self.view.backgroundColor = .white
        setElements()

        // Do any additional setup after loading the view.
    }
    
    func setElements() {
        self.view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            textField.topAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        
        self.view.addSubview(buttonSourceCurrency)
        buttonSourceCurrency.addTarget(self, action: #selector(showSheet), for: .touchUpInside)
        
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
        
        NSLayoutConstraint.activate([
            buttonDestinationCurrency.trailingAnchor.constraint(equalTo: buttonSourceCurrency.trailingAnchor),
            buttonDestinationCurrency.topAnchor.constraint(equalTo: label.topAnchor)
        ])
        
        
    }
    
    
    @objc func showSheet() {
        let sheetVC = CurrencyViewController(currencyViewModel: currencyViewModel)
        sheetVC.modalPresentationStyle = .pageSheet
        present(sheetVC, animated: true)
    }

}

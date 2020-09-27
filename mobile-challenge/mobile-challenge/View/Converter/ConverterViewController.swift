//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 25/09/20.
//

import UIKit

protocol ConverterViewControllerCoordinator: AnyObject {
    func currencyListView(buttonTapped: ButtonTapped)
}

class ConverterViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var sourceButton: UIButton!
    @IBOutlet weak var destinyButton: UIButton!
    @IBOutlet weak var inputValueTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var converterResultLabel: UILabel!
    
    weak var coordinator: ConverterViewControllerCoordinator?
    
    lazy var viewModel: ConverterViewModel = {
        let viewModel = ConverterViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupButtons()
    }

    @IBAction func goToCurrrencyListButton(_ sender: UIButton) {
        if sender == sourceButton {
            coordinator?.currencyListView(buttonTapped: .source)
        }
        else if sender == destinyButton {
            coordinator?.currencyListView(buttonTapped: .destiny)
        }
    }
    
    @IBAction func converterButtonAction(_ sender: Any) {
        do {
            let inputValue = try inputValidator(inputValueTextField.text)
            converterResultLabel.text = "\(performConversion(inputValue))"
        } catch {
            errorLabel.text = error.localizedDescription
            errorLabel.textColor = .red
        }
        
    }
    
    func performConversion(_ value: Double) -> Double {
        guard
            let source = viewModel.source,
            let destiny = viewModel.destiny,
            let sourceDollar = source.valueInDollar,
            let destinyDollar = destiny.valueInDollar
        else { return 0 }
        
        var returnValue: Double = 0
        
        if source.code == "USD" {
            returnValue = value * destinyDollar
        }
        else {
            returnValue = (value / sourceDollar) * destinyDollar
        }
        
        errorLabel.text = "\(source.code) -> \(destiny.code)"
        errorLabel.textColor = .black
        
        return returnValue
    }
    
    func setupButtons() {
        if let source = viewModel.source {
            sourceButton.setTitle(source.code, for: .normal)
        }
        
        if let destiny = viewModel.destiny {
            destinyButton.setTitle(destiny.code, for: .normal)
        }
    }
}

extension ConverterViewController {
    func inputValidator(_ value: String?) throws -> Double {
        guard var value = value else { throw ValidationError.inputIsNil }
        guard value.count > 0 else { throw ValidationError.inputIsEmpty }
        
        if value.contains(",") {
            value = value.replacingOccurrences(of: ",", with: ".")
        }
        
        guard let double = Double(value) else { throw ValidationError.inputIsNotDouble }
        guard double > 0 else { throw ValidationError.valueIsNegative }
        guard let _ = viewModel.source else { throw ValidationError.unselectedSourceCurrency }
        guard let _ = viewModel.destiny else { throw ValidationError.unselectedDestinyCurrency }
        
        return double
    }
}


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
    
    weak var coordinator: ConverterViewControllerCoordinator?
    
    lazy var viewModel: ConverterViewModel = {
        let viewModel = ConverterViewModel()
        return viewModel
    }()

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
            try inputValidator(inputValueTextField.text)
            errorLabel.text = ""
        } catch {
            errorLabel.text = error.localizedDescription
        }
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
    func inputValidator(_ value: String?) throws {
        guard var value = value else { throw InputValueError.inputIsNil }
        guard value.count > 0 else { throw InputValueError.inputIsEmpty }
        
        if value.contains(",") {
            value = value.replacingOccurrences(of: ",", with: ".")
        }
        
        guard let double = Double(value) else { throw InputValueError.inputIsNotDouble }
        guard double > 0 else { throw InputValueError.valueIsNegative }
    }
}


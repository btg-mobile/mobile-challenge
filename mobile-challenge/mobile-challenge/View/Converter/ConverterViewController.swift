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
            try viewModel.currenciesValidation()
            let inputValue = try viewModel.inputValidator(inputValueTextField.text)
            converterResultLabel.text = "\(viewModel.performConversion(inputValue))"
            
            errorLabel.text = "\(viewModel.source?.code ?? "") -> \(viewModel.destiny?.code ?? "")"
            errorLabel.textColor = .label
        } catch {
            errorLabel.text = error.localizedDescription
            errorLabel.textColor = .systemRed
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

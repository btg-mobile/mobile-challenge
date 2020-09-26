//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 25/09/20.
//

import UIKit

protocol ConverterViewControllerCoordinator: AnyObject {
    func currencyListView()
}

class ConverterViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var inputValueTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    weak var coordinator: ConverterViewControllerCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func originCurrrencyButton(_ sender: Any) {
        coordinator?.currencyListView()
    }
    
    @IBAction func destinyCurrencyButton(_ sender: Any) {
        coordinator?.currencyListView()
    }
    
    @IBAction func converterButtonAction(_ sender: Any) {
        do {
            try inputValidator()
            errorLabel.text = ""
        } catch {
            errorLabel.text = error.localizedDescription
        }
    }
}

extension ConverterViewController {
    func inputValidator() throws {
        guard let input = inputValueTextField.text else { throw InputValueError.inputIsNil }
        guard input.count > 0 else { throw InputValueError.inputIsEmpty }
    }
}


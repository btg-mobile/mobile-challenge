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
            try inputValidator(inputValueTextField.text)
            errorLabel.text = ""
        } catch {
            errorLabel.text = error.localizedDescription
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


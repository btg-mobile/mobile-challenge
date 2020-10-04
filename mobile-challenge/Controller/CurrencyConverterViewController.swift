//
//  CurrencyConverterViewController.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 03/10/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    @IBOutlet weak var originButton: UIButton!
    @IBOutlet weak var destinyButton: UIButton!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var converterButton: UIButton!
    @IBOutlet weak var convertedLabel: UILabel!
    
    var viewModel = CurrencyConverterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.title = viewModel.title
    }

    
    @IBAction func converterAction(_ sender: UIButton) {
        self.convertedLabel.text = "BRL >>> USD : 5,68"
    }
    
    @IBAction func originAction(_ sender: UIButton) {
        let vc = CurrencyListViewController(nibName: "CurrencyListViewController", bundle: nil)
        vc.typeConverter = .origin
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func destinyAction(_ sender: UIButton) {
        let vc = CurrencyListViewController(nibName: "CurrencyListViewController", bundle: nil)
        vc.typeConverter = .destiny
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func configureView() {
        self.originButton.layer.cornerRadius = 4
        self.destinyButton.layer.cornerRadius = 4
        self.currencyTextField.layer.cornerRadius = 4
        self.converterButton.layer.cornerRadius = 4
    }

}


extension CurrencyConverterViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

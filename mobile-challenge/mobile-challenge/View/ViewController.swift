//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Fernanda Sudré on 24/11/20.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var firstCurrency: UIButton!
   
    @IBOutlet weak var secondCurrency: UIButton!
    //    https://api.currencylayer.com/list?access_key=
    @IBOutlet weak var convertButton: UIButton!
    let currencyTypesService = CurrencyTypesService()
    var selected = ""

    let apiKey = "baa8ca67a82137316bb59b665428e101"
    override func viewDidLoad() {
        super.viewDidLoad()
//        amountTextField.text

        // Do any additional setup after loading the view.
        if firstCurrency.isSelected{
            firstCurrency.titleLabel?.text = selected
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CurrenciesViewController
    
        destination.acronyms = currencyTypesService.sendAcronyms()
        destination.currencyNames = currencyTypesService.sendCurrencyNames()
        destination.passCurrency = self
    }
    
    
    @IBAction func convertButton(_ sender: Any) {
        let amount = amountTextField.text
//        let first = firstCurrency.titleLabel?.text
        
    }
    
    @IBAction func firstCurrency(_ sender: Any) {

        
        
        
    }
    @IBAction func secondCurrency(_ sender: Any) {
        
        
    }
    
}
extension ViewController: PassCurrencyDelegate{
    func passCurrency(currency: String) {
        self.selected = currency
        firstCurrency.setTitle(currency, for: .normal)
//        if  firstCurrency.isSelected {
//            firstCurrency.setTitle(currency, for: .normal)
//        } else if secondCurrency.isSelected{
//            secondCurrency.setTitle(currency, for: .normal)
//        }
        
    }
    
    
}


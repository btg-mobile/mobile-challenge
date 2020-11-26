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
    
    @IBOutlet weak var firstCurrencyLabel: UILabel!
    @IBOutlet weak var secondCurrencyLabel: UILabel!
    @IBOutlet weak var firstCurrency: UIButton!
   
    @IBOutlet weak var secondCurrency: UIButton!
    //    https://api.currencylayer.com/list?access_key=
    @IBOutlet weak var convertButton: UIButton!
    let currencyTypesService = CurrencyTypesService()
    var selected = ""
    let currencyService = CurrencyService()

    let apiKey = "baa8ca67a82137316bb59b665428e101"
    var flag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadInputViews()
        firstCurrencyLabel.reloadInputViews()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CurrenciesViewController
    
        if segue.identifier == "currencyType1"{
            destination.acronyms = currencyTypesService.sendAcronyms()
            destination.currencyNames = currencyTypesService.sendCurrencyNames()
            destination.passCurrency = self
            destination.flag = 1
        }else {
            destination.acronyms = currencyTypesService.sendAcronyms()
            destination.currencyNames = currencyTypesService.sendCurrencyNames()
            destination.passCurrency = self
            destination.flag = 2
        }
        
    }
    
    
    @IBAction func convertButton(_ sender: Any) {
        let amount = amountTextField.text
//        let first = firstCurrency.titleLabel?.text
        
    }
    
    @IBAction func firstCurrency(_ sender: Any) {
        
        performSegue(withIdentifier: "currencyType1", sender: sender)
//        firstCurrency.setTitle(selected, for: .normal)
        
        
        
    }
    @IBAction func secondCurrency(_ sender: Any) {

        performSegue(withIdentifier: "currencyType2", sender: sender)
    }
    func changeTitle(selectedAcronym: String){
        firstCurrency.setTitle(selectedAcronym, for: .normal)
    }
}
extension ViewController: PassCurrencyDelegate{
    func passCurrency(currency: String,flag: Int) {
        self.selected = currency
        self.flag = flag
        print("FLAAAAG",flag)
        if flag == 1 {
            firstCurrencyLabel.text = currency
        }else if flag == 2{
            secondCurrencyLabel.text = currency
        }
    }
}


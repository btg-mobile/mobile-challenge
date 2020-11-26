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
    //Flag that
    var flag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //Function that prepares data to be sent to another view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CurrenciesViewController
    
        if segue.identifier == "currencyType1"{
            destination.acronyms = currencyTypesService.sendAcronyms()
            destination.currencyNames = currencyTypesService.sendCurrencyNames()
            destination.passCurrency = self
            destination.flag = 1
        }else if segue.identifier == "currencyType2"{
            destination.acronyms = currencyTypesService.sendAcronyms()
            destination.currencyNames = currencyTypesService.sendCurrencyNames()
            destination.passCurrency = self
            destination.flag = 2
        }
        
    }
    
    
    @IBAction func convertButton(_ sender: Any) {
        let amount = Double(amountTextField.text!)!
        currencyService.fetch(firstCurrency: firstCurrencyLabel.text!, secondCurrency: secondCurrencyLabel.text!, amount: amount)
        var num1 = currencyService.getValue1()
        var num2 = currencyService.getValue2()
        let result = currencyService.convert(num1: num1, num2: num2, amount: amount)
        resultLabel.text = String(result)
        print("E O RESULTADP É:",result)
    }
    
    @IBAction func firstCurrency(_ sender: Any) {
        performSegue(withIdentifier: "currencyType1", sender: sender)
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
        if flag == 1 {
            firstCurrencyLabel.text = currency
        }else if flag == 2{
            secondCurrencyLabel.text = currency
        }
    }
}


//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Fernanda Sudré on 24/11/20.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    ///Outlet of the textfield
    @IBOutlet weak var amountTextField: UITextField!
    ///Outlet of the results
    @IBOutlet weak var resultLabel: UILabel!
    ///Outlet of the First currency label
    @IBOutlet weak var firstCurrencyLabel: UILabel!
    ///Outlet of the Second currency label
    @IBOutlet weak var secondCurrencyLabel: UILabel!

    ///Outlet of the convert button
    @IBOutlet weak var convertButton: UIButton!
    ///Instance of the currency type service
    let currencyTypesService = CurrencyTypesService()
    ///Store the selected acronym
    var selectedAcronym = ""
    ///Instance of the currency service
    let currencyService = CurrencyService()
    //Flag that will determinate the button that was clicked on
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
    
    ///Function that sends the acronyms to fetch the data, converts the value and shows the result
    @IBAction func convertButton(_ sender: Any) {
        guard let amount = Double(amountTextField.text!) else{ return }
        currencyService.fetch(firstCurrency: firstCurrencyLabel.text!, secondCurrency: secondCurrencyLabel.text!, amount: amount)
        var num1 = currencyService.getValue1()
        var num2 = currencyService.getValue2()
        let result = currencyService.convert(num1: num1, num2: num2, amount: amount)
        resultLabel.text = String(result)
        
    }
    ///Function that calls the second view
    @IBAction func firstCurrency(_ sender: Any) {
        performSegue(withIdentifier: "currencyType1", sender: sender)
    }
    ///Function that calls the second view
    @IBAction func secondCurrency(_ sender: Any) {

        performSegue(withIdentifier: "currencyType2", sender: sender)
    }

}
extension ViewController: PassCurrencyDelegate{
    ///Function that sets the values according with the CurrenciesViewController values of the selected currency and the button that will change the value of the labels.
    func passCurrency(currency: String,flag: Int) {
        self.selectedAcronym = currency
        self.flag = flag
        if flag == 1 {
            firstCurrencyLabel.text = currency
        }else if flag == 2{
            secondCurrencyLabel.text = currency
        }
    }
}


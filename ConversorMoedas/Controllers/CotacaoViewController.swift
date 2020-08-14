//
//  CotacaoViewController.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 11/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import UIKit

class CotacaoViewController: UIViewController {

    var currencyOrigin: (key:String,value:String)?
    var currencyDestiny: (key:String,value:String)?
    var isButtonOriginTaped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        Quotation().getLive()

    }

    @IBAction func didTapOriginButton(_ sender: Any) {
        openCurrenciesList()
        isButtonOriginTaped = true
    }
    
    @IBAction func didTapDestinyButton(_ sender: Any) {
        openCurrenciesList()
        isButtonOriginTaped = false
    }
    
    @IBAction func didTapToConvert(_ sender: Any) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let valueToConvert = formatter.number(from: tfInputValue?.text ?? "0.0")
        
        Quotation().getLive(currencyOrigin?.key ?? "", currencyDestiny?.key ?? "", valueToConvert as! Double, { result in
            DispatchQueue.main.async {
                self.lbResult?.text = formatter.string(from: NSNumber(value: result))
            }
        })
    }
    
    
    @IBOutlet weak var btOrigin: UIButton!
    @IBOutlet weak var btDestiny: UIButton!
    @IBOutlet weak var tfInputValue: UITextField!
    @IBOutlet weak var lbResult: UILabel!
    
    func setCurrency(_ currency : (key:String,value:String)) {
        
        if(isButtonOriginTaped){
            currencyOrigin = currency
            btOrigin.setTitle(currency.value, for: .normal)
        }else{
            currencyDestiny = currency
            btDestiny.setTitle(currency.value, for: .normal)
        }
    }
    
    private func openCurrenciesList() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "list")
        present(vc, animated: true, completion: nil)
    }
}

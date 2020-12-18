//
//  MainViewController.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 17/12/20.
//

import UIKit

protocol SearchViewControllerDelegateSelectedCurrency: class {
    func selectedCurrency(_ currency: Currency)
}

class MainViewController: UIViewController {
    
    private let modelController = CurrencyMainViewModelController()
    
    @IBOutlet weak var resultCurrencyLabel: UILabel!
    
    @IBOutlet weak var firstCurrencyButton: UIButton!
    @IBOutlet weak var secondCurrencyButton: UIButton!
    
    var firstQuote : Quote?
    var secondQuote : Quote?
    
    @IBAction func firstCurrencyButton(_ sender: UIButton) {
        sender.isSelected = true
        showSearchCurrency()
    }
    
    @IBAction func secondCurrencyButton(_ sender: UIButton) {
        sender.isSelected = true
        showSearchCurrency()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modelController.updateRealTimeRates()
    }
    
    func showSearchCurrency(){
        guard  let searchView = self.storyboard?.instantiateViewController(withIdentifier: "searchCurrencyView") as? SearchCurrencyViewController else {
            fatalError("View Controller not found")
        }
        searchView.delegate = self
        self.present(searchView, animated: true)
    }
    
    
}

extension MainViewController: SearchViewControllerDelegateSelectedCurrency{
    func selectedCurrency(_ currency: Currency) {
        
        let quote = modelController.searchQuote(currency: currency)
        guard let _quote = quote else{return}
        
        if firstCurrencyButton.isSelected {
            firstCurrencyButton.setTitle(currency.abbreviation, for: .normal)
            firstQuote = _quote
        }else{
            secondCurrencyButton.setTitle(currency.abbreviation, for: .normal)
            secondQuote = _quote
        }
        
        firstCurrencyButton.isSelected = false
        secondCurrencyButton.isSelected = false
        
        if firstQuote != nil && secondQuote != nil {
            resultCurrencyLabel.text = "\(modelController.compareQuotes(first: self.firstQuote!, second: self.secondQuote!).rounded(toPlaces: 2))"
        }
    }
}

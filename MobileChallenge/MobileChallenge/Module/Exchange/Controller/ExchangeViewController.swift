//
//  ViewController.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

class ExchangeViewController: UIViewController {

    weak var coordinator: ExchangeViewControllerDelegate?
    
    lazy var exchangeView: ExchangeView = {
        var view = ExchangeView(frame: self.view.frame)
        
        view.firstCurrencyButton.addTarget(self, action: #selector(didTappedOnFirstCurrencyButton), for: .touchUpInside)
        
        view.secondCurrencyButton.addTarget(self, action: #selector(didTappedOnSecondCurrencyButton), for: .touchUpInside)
        
        return view
    }()
    
    func setUp() {
        self.title = "Exchange"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func didTappedOnFirstCurrencyButton(){
        coordinator?.goToCurrenciesList()
    }
    
    @objc func didTappedOnSecondCurrencyButton(){
        coordinator?.goToCurrenciesList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = exchangeView
        
        setUp()
    }
}


//
//  ViewController.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

class ExchangeViewController: UIViewController {

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
        
    }
    
    @objc func didTappedOnSecondCurrencyButton(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = exchangeView
        
        setUp()
    }
}


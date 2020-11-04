//
//  ViewController.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

class ExchangeViewController: UIViewController {

    weak var coordinator: ExchangeViewControllerDelegate?
    
    var exchangeViewModel: ExchangeViewModel
    
    lazy var exchangeView: ExchangeView = {
        var view = ExchangeView(frame: self.view.frame)
        
        view.firstCurrencyButton.addTarget(self, action: #selector(didTappedOnFirstCurrencyButton), for: .touchUpInside)
        
        view.secondCurrencyButton.addTarget(self, action: #selector(didTappedOnSecondCurrencyButton), for: .touchUpInside)
        
        return view
    }()
    
    func showError(text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
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
    
    init() {
        exchangeViewModel = ExchangeViewModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


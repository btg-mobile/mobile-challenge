//
//  CurrenciesController.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

class CurrenciesViewController: UIViewController {

    var coordinator: CurrenciesViewControllerDelegate?
    
    lazy var currenciesView: CurrenciesView = {
        let view = CurrenciesView(frame: self.view.frame)
        view.cancelBarButton.action = #selector(didTappedOnCancel)
        view.cancelBarButton.target = self
        
        return view
    }()
    
    @objc private func didTappedOnCancel() {
        coordinator?.returnToExchangesView()
    }
    
    func setUp() {
        self.title = "Currencies"
        self.view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = currenciesView
        
        setUp()
    }
}

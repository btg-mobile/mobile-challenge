//
//  CurrenciesController.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

class CurrenciesController: UIViewController {

    lazy var currenciesView: CurrenciesView = {
        let view = CurrenciesView(frame: self.view.frame)
        
        return view
    }()
    
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

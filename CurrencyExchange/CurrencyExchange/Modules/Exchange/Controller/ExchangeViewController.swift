//
//  ExchangeViewController.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: ExchangeViewModel
    
    private let exchangeView: ExchangeView = {
        let view = ExchangeView(frame: .zero)
        return view
    }()
    
    init(viewModel: ExchangeViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.exchangeView.originCurrencyButton.addTarget(self, action: #selector(tappedOnOriginButton), for: .touchUpInside)
        
        self.exchangeView.destinationCurrencyButton.addTarget(self, action: #selector(tappedOnDestinationButton), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = exchangeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
    }

    // MARK: - Selectors
    
    @objc func tappedOnOriginButton(){
        print("DEBUG: Tapped on origin button")
    }
    
    @objc func tappedOnDestinationButton(){
        print("DEBUG: Tapped on destination button")

    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

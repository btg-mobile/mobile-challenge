//
//  CurrenciesController.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//

import UIKit

class CurrenciesViewController: UIViewController {

    weak var coordinator: CurrenciesViewControllerDelegate?
    
    var currenciesViewModel: CurrenciesViewModel
    
    lazy var currenciesView: CurrenciesView = {
        let view = CurrenciesView(frame: self.view.frame)
        view.cancelBarButton.action = #selector(didTappedOnCancel)
        view.cancelBarButton.target = self
        
        return view
    }()
    
    func fetchAllCurrencies() {
        currenciesViewModel.fetchAllCurrencies { [weak self] (result) in
            
            switch result {
            case .success(let currencies):
                self?.currenciesViewModel.currencies = currencies
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showError(text: error.errorDescription)
                }
            }
        }
    }
    
    func showError(text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
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
    
    init() {
        self.currenciesViewModel = CurrenciesViewModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

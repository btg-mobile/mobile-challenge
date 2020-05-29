//
//  CoinConversionViewController.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import UIKit

class CoinConversionViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var currencyButtonFrom: CurrencyButton!
    @IBOutlet weak var currencyFromValue: UITextField!
    @IBOutlet weak var currencyToValue: UILabel!
    @IBOutlet weak var currencyButtonTo: CurrencyButton!
    @IBOutlet weak var convertButton: UIButton!
    
    
    // MARK: - Properties
    let viewModel: CoinConversionViewModelProtocol
    
    // MARK: - Initializer
    init(viewModel: CoinConversionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Setups
    private func setup() {
        setupButtonsDelegates()
        setupObservable()
    }
    
    private func setupButtonsDelegates() {
        self.currencyButtonTo.delegate = self
        self.currencyButtonFrom.delegate = self
    }
    
    private func setupObservable() {
        
        self.currencyFromValue.rx.controlEvent([.editingChanged]).subscribe(onNext: { _ in
            if let amount = self.currencyFromValue.text?.currencyInputFormatting() {
                self.currencyFromValue.text = amount
            }
        }).disposed(by: viewModel.disposeBag)
        
        self.viewModel.selectedCurrencyTo.asObservable().subscribe(onNext: { [weak self] currencyTo in
            guard let self = self, let currencyTo = currencyTo else {
                return
            }
            self.currencyButtonTo.coinLabel.text = currencyTo.currencyCode
        }).disposed(by: viewModel.disposeBag)
        
        self.viewModel.selectedCurrencyFrom.asObservable().subscribe(onNext: { [weak self] currencyFrom in
            guard let self = self, let currencyFrom = currencyFrom else {
                return
            }
            self.currencyButtonFrom.coinLabel.text = currencyFrom.currencyCode
        }).disposed(by: viewModel.disposeBag)
        
    }


}

// MARK: - Currency Button Delegate
extension CoinConversionViewController: CurrencyButtonDelegate {
    func tapCoinButton(view: CurrencyButton) {
     
        if view == currencyButtonFrom {
            self.navigationController?.pushViewController(CurrencyListViewController(viewModel: CurrencyListViewModel(currencySource: .from), delegate: self.viewModel), animated: true)
        } else if view == currencyButtonTo {
            self.navigationController?.pushViewController(CurrencyListViewController(viewModel: CurrencyListViewModel(currencySource: .to), delegate: self.viewModel), animated: true)
        }
    }
}


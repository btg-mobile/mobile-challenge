//
//  CoinConversionViewController.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

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
    
  
    
    // MARK: - UIActions
    @IBAction func convertButtonTap(_ sender: Any) {
        self.viewModel.getConversionValue()
    }
    
    
    
}

private extension CoinConversionViewController {
    // MARK: - Setups
      private func setup() {
          setupButtonsDelegates()
          setupObservable()
          setupUI()
      }
      
      private func setupButtonsDelegates() {
          self.currencyButtonTo.delegate = self
          self.currencyButtonFrom.delegate = self
      }
      
      private func setupObservable() {
          
        self.viewModel.error.asObservable().observeOn(MainScheduler.instance).map {$0 == nil ? "" : $0!} .filter({$0 != ""}).subscribe(onNext: { text in
                
            let alert = UIAlertController(title: "Erro", message: text, preferredStyle: .alert)
            let tryAgain = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(tryAgain)
            
            self.present(alert, animated: true)
            
        }).disposed(by: viewModel.disposeBag)
          
          self.viewModel.isLoading
              .asObservable()
              .bind(to: self.rx.animating)
              .disposed(by: viewModel.disposeBag)
          
          self.currencyFromValue
              .rx
              .controlEvent([.editingChanged])
              .subscribe(onNext: { _ in
                  if let amount = self.currencyFromValue.text?.currencyInputFormatting() {
                      self.currencyFromValue.text = amount
                      
                  }
              }).disposed(by: viewModel.disposeBag)
          
          
          self.currencyFromValue
              .rx
              .text
              .bind(to: self.viewModel.amount)
              .disposed(by: viewModel.disposeBag)
          
          self.viewModel.selectedCurrencyTo
              .asObservable()
              .subscribe(onNext: { [weak self] currencyTo in
                  guard let self = self, let currencyTo = currencyTo else {
                      return
                  }
                  self.currencyButtonTo.coinLabel.text = currencyTo.currencyCode
              }).disposed(by: viewModel.disposeBag)
          
          self.viewModel.selectedCurrencyFrom
              .asObservable()
              .subscribe(onNext: { [weak self] currencyFrom in
                  guard let self = self, let currencyFrom = currencyFrom else {
                      return
                  }
                  self.currencyButtonFrom.coinLabel.text = currencyFrom.currencyCode
              }).disposed(by: viewModel.disposeBag)
          
          self.viewModel.finalValue
              .asObservable()
              .bind(to: self.currencyToValue.rx.text)
              .disposed(by: viewModel.disposeBag)
          
      }
    
    private func setupUI() {
        self.title = "Conversão"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.convertButton.layer.cornerRadius = 8
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


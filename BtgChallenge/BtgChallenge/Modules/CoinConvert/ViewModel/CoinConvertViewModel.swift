//
//  CoinConvertViewModel.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

protocol CoinConvertViewModelDataStore: class {
    var fromCoinNickname: String { get set }
    var fromCoinValue: String { get set }
    var toCoinNickname: String { get set }
}

protocol CoinConvertViewModelInput: class {
    func getInitialScreenValues()
    func getConversionQuote()
    func updateFromCoinValue(value: String)
}

protocol CoinConvertViewModelOutput: class {
    func displayLoadingView()
    func hideLoadingView()
    func displayAlertMessage(message: String)
    
    func displayFromCoinNickname(coinNickname: String)
    func displayToCoinNickname(coinNickname: String)
    func displayConversionValue(conversionValue: String)
}

final class CoinConvertViewModel: CoinConvertViewModelDataStore {
    
    var fromCoinNickname = "BRL"
    var fromCoinValue = "0.00"
    var toCoinNickname = "USD"
    
    fileprivate let repository: CurrencyRepository
    weak var viewController: CoinConvertViewModelOutput?
    
    init(repository: CurrencyRepository) {
        self.repository = repository
    }
    
}

// MARK: - Inputs
extension CoinConvertViewModel: CoinConvertViewModelInput {
    func getInitialScreenValues() {
        
    }
    
    func getConversionQuote() {
        viewController?.displayLoadingView()
        repository
            .live(fromCoinNickname, toCoinNickname) { [weak self] liveResult in
                self?.viewController?.hideLoadingView()
                
                switch liveResult {
                case .success(let liveResponse):
                    self?.displayConversionValue(liveResponse: liveResponse)
                case .failure(_):
                    self?.displayAlertMessage(message: Constants.Errors.apiDefaultMessage)
                }
            }
    }
    
    func updateFromCoinValue(value: String) {
        fromCoinValue = value
    }
}

// MARK: - Outputs
extension CoinConvertViewModel {
    func displayFromCoinNickname(coinNickname: String) {
        
    }
    
    func displayToCoinNickname(coinNickname: String) {
        
    }
    
    func displayConversionValue(liveResponse: LiveResponse) {
        let quote = liveResponse.quotes[toCoinNickname + fromCoinNickname] ?? 0.0
        let conversionValue = String(fromCoinValue.double * quote)
        let formatedValue = BtgCurrencyFormatter().format(string: conversionValue)
        
        viewController?.displayConversionValue(conversionValue: formatedValue)
    }
    
    func displayAlertMessage(message: String) {
        viewController?.displayAlertMessage(message: message)
    }
}

//
//  CoinConversionViewModel.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
protocol CoinConversionViewModelProtocol: CurrencyListViewControllerDelegate {
    
    func formatMoney(value: String) -> String
    var disposeBag: DisposeBag { get }
    var selectedCurrencyFrom: BehaviorRelay<FormattedCurrency?> { get }
    var selectedCurrencyTo: BehaviorRelay<FormattedCurrency?> { get }
}


class CoinConversionViewModel {
    
    private let _disposeBag = DisposeBag()
    private let _selectedCurrencyFrom = BehaviorRelay<FormattedCurrency?>(value: nil)
    private let _selectedCurrencyTo = BehaviorRelay<FormattedCurrency?>(value: nil)
    
    init() {
        _selectedCurrencyFrom.accept(FormattedCurrency(currencyCode: "BRL", currencyName: "Brazilian Real"))
        _selectedCurrencyTo.accept(FormattedCurrency(currencyCode: "EUR", currencyName: "Euro"))
    }
    
    
}
extension CoinConversionViewModel: CoinConversionViewModelProtocol {
    var selectedCurrencyFrom: BehaviorRelay<FormattedCurrency?> {
        return _selectedCurrencyFrom
    }
    
    var selectedCurrencyTo: BehaviorRelay<FormattedCurrency?> {
        return _selectedCurrencyTo
    }
    
    
    func formatMoney(value: String) -> String {
        return value.currencyInputFormatting()
    }
    
    var disposeBag: DisposeBag {
        return _disposeBag
    }
 
    func didSelectNewCurrency(formattedCurrency: FormattedCurrency, source: CurrencySource) {
        if source == .from {
            self.selectedCurrencyFrom.accept(formattedCurrency)
        } else {
            self.selectedCurrencyTo.accept(formattedCurrency)
        }
    }
    
}

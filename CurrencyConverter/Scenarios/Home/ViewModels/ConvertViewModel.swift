//
//  ConvertViewModel.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 13/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class ConvertViewModel {

    // MARK: - Properties

    private let disposeBag = DisposeBag()
    let fromText = BehaviorRelay<String>(value: "")
    let toText = BehaviorRelay<String>(value: "")
    let convertedText = BehaviorRelay<String>(value: "0")
    let changeText = BehaviorRelay<String>(value: "0")
    var fromCurrencie = BehaviorRelay<CurrencieModel>(value: CurrencieModel())
    var toCurrencie = BehaviorRelay<CurrencieModel>(value: CurrencieModel())

    init() {
        handleValueTextChange()
    }

    // MARK: - Actions

    func handleValueTextChange() {
        changeText
            .subscribe { event -> Void in
                switch event {
                case let .next(next):
                    self.convertCurrencies(next)
                case let .error(error):
                    print(error)
                case .completed: break
                }
            }.disposed(by: disposeBag)
    }
    
    func convertCurrencies(_ inputValue: String) {
        let fromQuote = fromCurrencie.value.quote
        let toQuote = toCurrencie.value.quote
        var validInputValue = "0"
        
        if !inputValue.isEmpty {
            validInputValue = inputValue
        }
        
        if let inputValue = Double(validInputValue.replacingOccurrences(of: ",", with: ".")) {
            var convertedValue:Double = 0
            
            if fromQuote > 0 {
                convertedValue = (toQuote / fromQuote) * inputValue
            }
            
            convertedText.accept(String(format: "%.6f", convertedValue).replacingOccurrences(of: ".", with: ","))
        }
    }
}

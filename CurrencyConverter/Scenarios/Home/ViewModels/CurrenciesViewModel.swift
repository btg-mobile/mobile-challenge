//
//  CurrenciesViewModel.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class CurrenciesViewModel {
    
    // MARK: - Properties
    var currencies: Single<[CurrencieModel]>?
    let isSelected = BehaviorRelay<Bool>(value: false)
    let disposeBag = DisposeBag()

    init(currenciesRepository: CurrenciesRepository) {
        currenciesRepository.getCurrencies()
            .subscribe { event -> Void in
                switch event {
                case let .success(data):
                    print(data)
                case let .error(error):
                    print(error)
                }
            }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions

       func toggleCurrencie(isSelected: Bool) {
           print("currencie selected")
       }
}

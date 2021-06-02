//
//  CoinListViewModelTests.swift
//  Desafio iOSTests
//
//  Created by Lucas Soares on 30/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CoinListViewModelTests: CurrencyListViewModelProtocol {
    
    
    private let formattedCurrencies = [
        FormattedCurrency(currencyCode: "USD", currencyName: "United States Dollar"),
        FormattedCurrency(currencyCode: "BRL", currencyName: "Brazilian Real"),
        FormattedCurrency(currencyCode: "CAD", currencyName: "Canadian Dollar"),
        FormattedCurrency(currencyCode: "LRD", currencyName: "Liberian Dollar")
    ]
    var errorObservable: BehaviorRelay<String?>
    
    var disposeBag: DisposeBag
    
    var currencySource: CurrencySource
    
    var isLoading: BehaviorRelay<Bool>
    
    var list = BehaviorRelay<[FormattedCurrency]>(value: [])
    
    func getList() {
        list.accept(formattedCurrencies)
    }
    
    func filterList(predicate: String) -> Observable<[FormattedCurrency]> {
        if predicate == "" {
              return self.list.asObservable()
          } else {
              var mList = self.list.value
              mList = mList.filter( { $0.currencyCode.lowercased().contains(predicate.lowercased()) || $0.currencyFullName.lowercased().contains(predicate.lowercased())})
              return .just(mList)
          }
    }
    
    init() {
        errorObservable = BehaviorRelay<String?>(value: nil)
        disposeBag = DisposeBag()
        currencySource = .to
        isLoading = BehaviorRelay<Bool>(value: false)
        
    }
    
}

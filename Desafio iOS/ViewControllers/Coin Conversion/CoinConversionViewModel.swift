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

protocol CoinConversionViewModelProtocol {
    var currencyListObservable: Observable<CurrenciesListResponse?> { get }
    var disposeBag: DisposeBag { get }
    func getList()
}


class CoinConversionViewModel {
    
    private let _disposeBag = DisposeBag()
    private let currencyList = BehaviorRelay<CurrenciesListResponse?>(value: nil)
    
}
extension CoinConversionViewModel: CoinConversionViewModelProtocol {
    
    var disposeBag: DisposeBag {
        return _disposeBag
    }
    
    var currencyListObservable: Observable<CurrenciesListResponse?> {
        return currencyList.asObservable()
    }
    
    func getList() {
        let httpManager = HTTPManager<CurrencyRouter>()
        CurrencyLayerService(httpManager: httpManager).getCurrenciesList { (result) in
            if let response = result.result {
                self.currencyList.accept(response)
            }
            
        }
    }
}

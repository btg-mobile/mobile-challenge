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

enum CurrencySource: String {
    case to = "to"
    case from = "from"
}

protocol CurrencyListViewModelProtocol {
    var errorObservable: BehaviorRelay<String?> { get }
    var disposeBag: DisposeBag { get }
    var currencySource: CurrencySource { get }
    var isLoading: BehaviorRelay<Bool> { get }
    func getList()
    func filterList(predicate: String) -> Observable<[FormattedCurrency]>
    
}


class CurrencyListViewModel {
    
    private let _disposeBag = DisposeBag()
    private let _currencyList = BehaviorRelay<[FormattedCurrency]>(value: [])
    private let _error = BehaviorRelay<String?>(value: nil)
    private let _currencySource: CurrencySource
    private let httpManager: HTTPManager<CurrencyRouter>
    private let _isLoading = BehaviorRelay<Bool>(value: false)
    private var service: CurrencyLayerService
    init(currencySource: CurrencySource, httpManager: HTTPManager<CurrencyRouter> = HTTPManager<CurrencyRouter>()) {
        self._currencySource = currencySource
        self.httpManager = httpManager
        service = CurrencyLayerService(httpManager: httpManager)
    }
    
    
}

extension CurrencyListViewModel: CurrencyListViewModelProtocol {
    
    var isLoading: BehaviorRelay<Bool> {
        return _isLoading
    }
    
    var currencySource: CurrencySource {
        return _currencySource
    }
    
    var disposeBag: DisposeBag {
        return _disposeBag
    }
    
    var errorObservable: BehaviorRelay<String?> {
        return _error
    }
    
    func getList() {
        _isLoading.accept(true)
        service.getCurrenciesList { (result) in
            self._isLoading.accept(false)
            if let response = result.result, let currencies = response.currencies {
                self._currencyList.accept(self.setupFormattedListWith(dictionary: currencies.coinsDictionary))
            } else if let errorDesc = result.failure?.localizedDescription {
                self._isLoading.accept(false)
                self.errorObservable.accept(errorDesc)
            }
            
        }
    }
    
    private func setupFormattedListWith(dictionary currencies: [String: String?]) -> [FormattedCurrency] {
        return currencies.compactMap { element in
            guard let value = element.value else {
                return nil
            }
            let formattedCurrency = FormattedCurrency(currencyCode: element.key, currencyName: value)
            return formattedCurrency
        
        }.sorted(by: { $0.currencyCode < $1.currencyCode })
    
    }
    
    func filterList(predicate: String) -> Observable<[FormattedCurrency]> {
        
        if predicate == "" {
            return self._currencyList.asObservable()
        } else {
            var list = self._currencyList.value
            list = list.filter( { $0.currencyCode.lowercased().contains(predicate.lowercased()) || $0.currencyFullName.lowercased().contains(predicate.lowercased())})
            return .just(list)
        }
        
    }
 }

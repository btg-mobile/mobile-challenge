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
    var currencies = BehaviorRelay<[CurrencieModel]>(value: [])
    private let allCurrencies = BehaviorRelay<[CurrencieModel]>(value: [])
    var isLoading = BehaviorRelay(value: true)
    let filter = BehaviorRelay<String?>(value: nil)
    let sortAZ = BehaviorRelay<Bool>(value: true)
    private let disposeBag = DisposeBag()

    init(currenciesRepository: CurrenciesRepository) {
        fetchCurrencies(currenciesRepository)
        searchCurrencies()
        sortCurrencies()
    }

    // MARK: - Actions

    func fetchCurrencies(_ currenciesRepository: CurrenciesRepository) {
        currenciesRepository.getCurrencies()
            .asObservable()
            .subscribe { event -> Void in
                switch event {
                case let .next(next):
                    let currencies = self.sort(self.sortAZ.value, next)
                    self.currencies.accept(currencies)
                    self.allCurrencies.accept(currencies)
                case let .error(error):
                    print(error)
                case .completed:
                    self.isLoading.accept(false)
                }
            }.disposed(by: disposeBag)
    }

    func searchCurrencies() {
        Observable.combineLatest(allCurrencies.asObservable(), filter.asObservable()) { (all: [CurrencieModel], text: String?) -> [CurrencieModel] in
            let allSorted = self.sort(self.sortAZ.value, all)
            if let text = text, !text.isEmpty {
                return allSorted.filter({ $0.name.lowercased().contains(text.lowercased()) })
            } else {
                return allSorted
            }
        }.bind(to: currencies).disposed(by: disposeBag)
    }

    func sortCurrencies() {
        sortAZ
        .subscribe { event -> Void in
            switch event {
            case let .next(next):
                let currencies = self.sort(next, self.currencies.value)
                self.currencies.accept(currencies)
            case let .error(error):
                print(error)
            case .completed:
                print("completed")
            }
        }.disposed(by: disposeBag)
    }
    
    func tapSortButton() {
        sortAZ.accept(!sortAZ.value)
    }
    
    func sort(_ az: Bool, _ currencies: [CurrencieModel]) -> [CurrencieModel] {
        return currencies.sorted { az ? ($0.name < $1.name) : ($0.name > $1.name) }
    }
    
    func tapCurrencie() {
        print("currencie selected")
    }
    
    func tapConvert() {
        print("convert currencies")
    }
}

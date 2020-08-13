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

    private let disposeBag = DisposeBag()
    private var currenciesRepository: CurrenciesRepository
    private let allCurrencies = BehaviorRelay<[CurrencieModel]>(value: [])
    var currencies = BehaviorRelay<[CurrencieModel]>(value: [])
    var isLoading = BehaviorRelay(value: true)
    let filter = BehaviorRelay<String?>(value: nil)
    let sortAZ = BehaviorRelay<Bool>(value: true)
    let fromText = BehaviorRelay<String>(value: "")
    let toText = BehaviorRelay<String>(value: "")
    let converterEnabled = BehaviorRelay<Bool>(value: false)
    let cleanEnabled = BehaviorRelay<Bool>(value: false)
    let tryAgainTextHidden = BehaviorRelay<Bool>(value: true)
    let tryAgainButtonHidden = BehaviorRelay<Bool>(value: true)

    init(currenciesRepository: CurrenciesRepository) {
        self.currenciesRepository = currenciesRepository
        fetchCurrencies()
        searchCurrencies()
        sortCurrencies()
    }

    // MARK: - Actions

    func fetchCurrencies() {
        self.isLoading.accept(true)
        self.tryAgainTextHidden.accept(true)
        self.tryAgainButtonHidden.accept(true)
        currenciesRepository.getCurrencies()
            .subscribe { event -> Void in
                switch event {
                case let .success(next):
                    self.isLoading.accept(false)
                    let currencies = self.sort(self.sortAZ.value, next)
                    self.currencies.accept(currencies)
                    self.allCurrencies.accept(currencies)
                case let .error(error):
                    print(error)
                    self.tryAgainTextHidden.accept(false)
                    self.tryAgainButtonHidden.accept(false)
                    self.isLoading.accept(false)
                }
            }.disposed(by: disposeBag)
    }

    func searchCurrencies() {
        Observable.combineLatest(allCurrencies.asObservable(), filter.asObservable()) { (all: [CurrencieModel], text: String?) -> [CurrencieModel] in
            let allSorted = self.sort(self.sortAZ.value, all)
            if let text = text, !text.isEmpty {
                return allSorted.filter({ $0.name.lowercased().contains(text.lowercased()) || $0.nameFull.lowercased().contains(text.lowercased()) })
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

    //Retorna false se o "De" e "Para" já estivem setado para exibir uma mensagem de alerta na view.
    func tapCurrencie(_ currencie: CurrencieModel) -> Bool! {
        let from = fromText.value
        let to = toText.value
        let set = from.isEmpty || to.isEmpty

        if from.isEmpty {
            fromText.accept(currencie.name)
        } else if to.isEmpty {
            toText.accept(currencie.name)
        }

        if !fromText.value.isEmpty {
            cleanEnabled.accept(true)

            if !toText.value.isEmpty {
                converterEnabled.accept(true)
            }
        }

        return set
    }

    func tapConvert() {
        print("convert currencies")
    }

    func tapClean() {
        fromText.accept("")
        toText.accept("")
        converterEnabled.accept(false)
        cleanEnabled.accept(false)
    }

    func sameCurrencie(toCurrencie: CurrencieModel) -> Bool {
        return fromText.value == toCurrencie.name
    }
    
    func tapTryAgain() {
        fetchCurrencies()
    }
}

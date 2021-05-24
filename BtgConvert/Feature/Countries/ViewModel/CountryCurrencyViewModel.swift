//
//  CountryCurrencyViewModel.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 30/04/21.
//

import Foundation
import PKHUD

public typealias UpdatedClosure = () -> ()

class CountryCurrencyViewModel {
    
    public var updatedList: UpdatedClosure?
    private var repository: CountryCurrencyRepositoryDelegate = CountryCurrencyRepository()
    private var currenciesSearch: [CountryCurrencyModel] = []
    private var message: MessageDeletate = Message()
    
    private var currencies: [CountryCurrencyModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.updatedList?()
            }
        }
    }
    
    func bindData() {
        HUD.show(.progress)
        repository.getCountriesCorrencies { (response) in
            let result = try! response.get()
            self.currencies = result.getCurrencies()
            self.currenciesSearch = self.currencies
            self.sort()
            HUD.hide()
        }
    }
    
    func numberOfRows() -> Int? {
        let rows = currencies.count
        if rows == 0 {
            bindData()
        }
        return currencies.count
    }
    
    func getItem(forIndex index: Int) -> CountryCurrencyModel {
        return currencies[index]
    }

    func cellViewModel(forIndex index: Int) -> CellCountryCurrency {
        if index < currencies.count {
            return CellCountryCurrency(currencies[index])
        }
        return CellCountryCurrency(CountryCurrencyModel(name: "", ref: ""))
    }
    
    func research(text: String) {
        DispatchQueue.main.async {
            let searchCountries = self.currenciesSearch.filter({ $0.name.starts(with: text) })
            guard searchCountries.count > 0 else {
                self.currencies = self.currenciesSearch
                self.message.showError(message: "Nenhum país encontrado!")
                return
            }
            self.currencies = searchCountries
        }
    }
    
}

extension CountryCurrencyViewModel {
    func sort() {
        self.currencies = self.currencies.sorted(by: { $0.name < $1.name })
    }
}

class CellCountryCurrency {
    private let countryCurrencyModel: CountryCurrencyModel?
    
    init(_ countryCurrencyModel: CountryCurrencyModel) {
        self.countryCurrencyModel = countryCurrencyModel
    }
    
    func getName() -> String {
        return countryCurrencyModel?.name ?? ""
    }
    
    func getRef() -> String {
        return countryCurrencyModel?.ref ?? ""
    }
}

//
//  CurrencyListViewModel.swift
//  Curriencies
//
//  Created by Ferraz on 04/09/21.
//

protocol CurrencyListViewModeling {
    var delegate: ChangeCurrencyDelegate? { get set }
    
    func numberOfSections() -> Int
    func numberOfRows() -> Int
    func cellForItemAt(_ row: Int) -> CurrencyCellModel
    func didSelectCellAt(_ row: Int)
}

protocol ChangeCurrencyDelegate: AnyObject {
    func updateNewCurrency(title: String, type: CurrencyType)
}

final class CurrencyListViewModel {
    let currencies: [CurrencyEntity]
    let type: CurrencyType
    weak var delegate: ChangeCurrencyDelegate?
    
    init(currencies: [CurrencyEntity], currencyType: CurrencyType) {
        self.currencies = currencies
        self.type = currencyType
    }
}

extension CurrencyListViewModel: CurrencyListViewModeling {
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows() -> Int {
        currencies.count
    }
    
    func cellForItemAt(_ row: Int) -> CurrencyCellModel {
        guard currencies.count > row else {
            return CurrencyCellModel(name: "Dólar", code: "USD")
        }
        return CurrencyCellModel(name: currencies[row].name,
                                 code: currencies[row].code)
    }
    
    func didSelectCellAt(_ row: Int) {
        guard currencies.count > row else { return }
        delegate?.updateNewCurrency(title: currencies[row].code, type: type)
    }
}

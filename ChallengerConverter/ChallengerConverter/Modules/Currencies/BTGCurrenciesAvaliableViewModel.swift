//
//  BTGCurrenciesAvaliableViewModel.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 22/10/21.
//

import Foundation

protocol BTGCurrenciesAvaliableViewModelDelegate: class {
    func didChoiseCurrency(currency: Currency)
}

class BTGCurrenciesAvaliableViewModel {
    
    let repository: CurrencyRepositoryProtocol
    
    var currenciesAvaliable: [Currency] = []
    var currenciesToShow: [Currency] = []
    
    var didUpdateList: (()-> Void)?
    var didShowError: ((String)-> Void)?
    
    weak var delegate: BTGCurrenciesAvaliableViewModelDelegate?
    
    init(repository: CurrencyRepositoryProtocol) {
        self.repository = repository
    }
    
    init(repository: CurrencyRepositoryProtocol, delegate: BTGCurrenciesAvaliableViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
}

extension BTGCurrenciesAvaliableViewModel {
    func fetchCurrenciesAvaliable() {
        self.repository.currecnyAvaliable { [unowned self] currencies in
            self.currenciesAvaliable = currencies
            self.currenciesToShow.append(contentsOf: currenciesAvaliable)
            self.didUpdateList?()
        } fail: { [unowned self] error in
            self.didShowError?(error)
        }
    }
    
    func filterCurrencies(textSearched: String) {
        currenciesToShow.removeAll()
        
        if(textSearched.isEmpty) {
            currenciesToShow.append(contentsOf: currenciesAvaliable)
            didUpdateList?()
            return
        }
        
        currenciesToShow.append(contentsOf:
                                    currenciesAvaliable.filter { currency in
                                            return currency.code.contains(textSearched) || currency.name.contains(textSearched)
                                }
        )
        
        didUpdateList?()
    }
    
    func numberCurrenciesToShow()-> Int {
        currenciesToShow.count
    }
    
    func didSelectCurrency(at index: Int) {
        self.delegate?.didChoiseCurrency(currency: currenciesToShow[index])
    }
}

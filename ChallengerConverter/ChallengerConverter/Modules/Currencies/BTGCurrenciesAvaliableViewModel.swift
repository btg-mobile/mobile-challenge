//
//  BTGCurrenciesAvaliableViewModel.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 22/10/21.
//

import Foundation

protocol BTGCurrenciesAvaliableViewModelDelegate: AnyObject {
    func didChoiseCurrency(currency: Currency)
}

class BTGCurrenciesAvaliableViewModel {
    
    var currenciesAvaliable: [Currency] {
        return LocalPreferencesRepostirory.shared.find() ?? []
    }
    
    var currenciesToShow: [Currency] = []
    
    var didUpdateList: (()-> Void)?
    var didShowError: ((String)-> Void)?
    
    weak var delegate: BTGCurrenciesAvaliableViewModelDelegate?
    
    init(delegate: BTGCurrenciesAvaliableViewModelDelegate) {
        self.delegate = delegate
    }
}

extension BTGCurrenciesAvaliableViewModel {
    
    func viewDidLoad() {
        currenciesToShow = currenciesAvaliable
        self.didUpdateList?()
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
                                            return currency.code.caseInsensitiveContain(textSearched) || currency.name.caseInsensitiveContain(textSearched)
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

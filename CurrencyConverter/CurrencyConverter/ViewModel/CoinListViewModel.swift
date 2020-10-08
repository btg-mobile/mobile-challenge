//
//  CoinListViewModel.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 07/10/20.
//

import UIKit

protocol CoinListViewModelDelegate {
    func didGetListModel()
    func didErrorOcurred(error: String)
}

class CoinListViewModel {
    
    private var allCoins: [CoinViewModel] = [CoinViewModel]()
    
    public private(set) var listCoins: [CoinViewModel]? {
        didSet {
            delegate?.didGetListModel()
        }
    }
    
    var delegate: CoinListViewModelDelegate?
    
    init() {
        self.getList()
    }
    
    private func getList() {
        
        CurrencyService.shared.getList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let model):
                if model.success ?? false {
                    var listCoins = [CoinViewModel]()
                    
                    if let currencies = model.currencies {
                        listCoins = currencies.map({ CoinViewModel(initials: $0.key, name: $0.value) })
                    }
                    
                    self.allCoins = listCoins.sorted { $0.name < $1.name }
                    
                    self.listCoins = self.allCoins
                } else {
                    self.delegate?.didErrorOcurred(error: CoinError.invallidData.rawValue)
                }
            case .failure(let error):
                self.delegate?.didErrorOcurred(error: error.rawValue)
            }
            
        }
        
    }
    
    func filter(by text: String) {
        self.listCoins = allCoins.filter({ $0.initials.lowercased().contains(text.lowercased()) || $0.name.lowercased().contains(text.lowercased()) })
    }
    
}

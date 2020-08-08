//
//  HomeViewModel.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 07/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation

final class HomeViewModel {
    
    private let repository: HomeRepository!
    var didSuccess: (() -> ())?
    var didFailure: ((String) -> ())?
    let dispatchGroup = DispatchGroup()
    var quotes: Quotes?
    var list: [String] = []
    var currencyIn: String?
    var currencyOut: String?
    
    init(_ repository: HomeRepository = HomeRepository()) {
        self.repository = repository
    }
    
    func fetchData() {
        dispatchGroup.enter()
        dispatchGroup.notify(queue: .main) {
            self.didSuccess?()
        }
        
        repository.fetchLive({ [weak self] quotes, error in
            guard let self = self, let quotes = quotes else {return}
            
            self.quotes = quotes
            if self.list.isEmpty {return}
            self.didSuccess?()
        })
        
        repository.fetchList({ [weak self] list, error in
            guard let self = self, let list = list else {return}
            
            self.list = list
            if self.quotes == nil {return}
            self.didSuccess?()
        })
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 10) {
            self.dispatchGroup.suspend()
            
            if self.quotes == nil || self.list.isEmpty {
                self.didFailure?("Não foi possivel estabelecer contato com o serviço.")
            }
            self.didSuccess?()
        }
    }
}

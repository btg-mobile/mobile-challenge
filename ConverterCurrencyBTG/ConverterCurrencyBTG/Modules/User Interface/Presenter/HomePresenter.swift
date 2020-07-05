//
//  HomePresenter.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class HomePresenter: HomePresenterInput {

    weak var output: HomePresenterOutput?
    var route: HomeWireframe
    var interactor: HomeInteractorInput
    
    init(route: HomeWireframe, interactor: HomeInteractorInput) {
        self.route = route
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.loadRequest()
    }
    
    func send(toCurrency: String, fromCurrency: String, amount: Decimal) {
        interactor.convert(toCurrency: toCurrency, fromCurrency: fromCurrency, amount: amount)
    }
}

extension HomePresenter: HomeInteractorOutput {
    
    func converted(sum: Decimal) {
        guard let sumString = sum.toString()?.toCurrency() else {
            return
        }
        self.output?.converted(sum: sumString)
    }
    
    func fetched(entites: [HomeEntity]) {
        guard let to = entites.first(where: { $0.currency == "BRL"}),
            let from =  entites.first(where: { $0.currency ==  "EUR"}),
            let imageTo = UIImage(named: to.currency.lowercased()),
            let imageFrom = UIImage(named: to.currency.lowercased()) else {
                return
        }
        
        DispatchQueue.main.async {
            self.output?.load(toViewModel: HomeViewModel(name: to.name, currency: to.currency, imageView: imageTo), fromViewModel: HomeViewModel(name: from.name, currency: from.currency, imageView: imageFrom))
        }
    }
    
}

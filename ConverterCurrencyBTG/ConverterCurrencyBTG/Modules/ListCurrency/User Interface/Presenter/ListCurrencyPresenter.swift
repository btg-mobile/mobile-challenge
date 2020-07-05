//
//  ListCurrencyPresenter.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class ListCurrencyPresenter: ListCurrencyPresenterInput {
    weak var ouput: ListCurrencyPresenterOuput?
    var wireframe: ListCurrencyWireframe
    var interactor: ListCurrencyInteractorInput
    var removeSymbol: String
    init(interactor: ListCurrencyInteractorInput, wireframe: ListCurrencyWireframe, removeSymbol: String) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.removeSymbol = removeSymbol
    }
    
    func viewDidLoad() {
        self.interactor.loadData()
    }
    
    func didSelected(viewModel: ListViewModel) {
        let homeViewModel = HomeViewModel(name: viewModel.name, currency: viewModel.currency, imageView: viewModel.imageView)
        self.wireframe.updateCurrency(viewModel: homeViewModel)
    }
}

extension ListCurrencyPresenter: ListCurrencyInteractorOuput {
    
    func fetched(entites: [HomeEntity]) {
        let filtered = entites.filter({ $0.currency != removeSymbol })
        DispatchQueue.main.async {
        self.ouput?.loadView(viewModels: filtered.map({ ListViewModel(name: $0.name, currency: $0.currency, imageView: UIImage(named: $0.currency.lowercased())) }))
        }
    }
}

//
//  HomePresenter.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation


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
}

extension HomePresenter: HomeInteractorOutput {
    
    func fetched(entites: [HomeEntity]) {
        dump(entites)
    }

}

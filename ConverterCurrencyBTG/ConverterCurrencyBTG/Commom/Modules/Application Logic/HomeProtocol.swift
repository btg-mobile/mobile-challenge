//
//  HomeProtocol.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

protocol HomePresenterOutput: class {
    
}
protocol HomePresenterInput {
    func viewDidLoad()
}

protocol HomeInteractorInput {
    func loadRequest()
}

protocol HomeInteractorOutput: class {
    func fetched(entites: [HomeEntity])
}

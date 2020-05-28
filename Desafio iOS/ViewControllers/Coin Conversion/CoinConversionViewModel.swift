//
//  CoinConversionViewModel.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CoinConversionViewModelProtocol {
    
    func getList()
}


class CoinConversionViewModel {
    
}
extension CoinConversionViewModel: CoinConversionViewModelProtocol {
    func getList() {
        let httpManager = HTTPManager<CurrencyRouter>()
        CurrencyLayerService(httpManager: httpManager).getCurrenciesList { (result) in
            
            
        }
    }
}

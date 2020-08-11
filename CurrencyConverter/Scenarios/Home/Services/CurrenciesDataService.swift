//
//  CurrenciesDataService.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper
import Moya_ObjectMapper
import SwiftyJSON

final class CurrenciesDataService: CurrenciesRepository {
    private let provider = MoyaProvider<CurrenciesService>()
    
    func getCurrencies() -> Single<[CurrencieModel]> {
        return provider.rx
        .request(.getCurrencies)
        .filterSuccessfulStatusCodes()
        .mapArray(CurrencieModel.self)
        
    }
    
    func getQuotes() -> Single<[QuoteModel]> {
        return provider.rx
        .request(.getQuotes)
        .filterSuccessfulStatusCodes()
        .mapArray(QuoteModel.self)
    }
}

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
import SwiftyJSON

final class CurrenciesDataService: CurrenciesRepository {
    private let provider = MoyaProvider<CurrenciesService>()
    let disposeBag = DisposeBag()

    func getCurrencies() -> Single<[CurrencieModel]> {
        return provider.rx
            .request(.getCurrencies)
            .map { single in
                let json = try JSON(single.mapJSON())
                var currencies: [CurrencieModel] = []

                for (key, subJson) in json["currencies"] {
                    currencies.append(CurrencieModel(name: key, nameFull: subJson.string!))
                }

                return currencies
        }

    }

    func getQuotes() -> Single<[QuoteModel]> {
        return provider.rx
            .request(.getQuotes)
            .map { single in
                let quotes: [QuoteModel] = []
                return quotes
            }
    }
}

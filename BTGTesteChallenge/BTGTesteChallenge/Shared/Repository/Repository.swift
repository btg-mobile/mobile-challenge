//
//  Repository.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/4/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import Foundation

protocol BaseRepositoryProtocol {
    var baseURL: String { get } //retrieve from plist
    var key: String { get } //retrieve from plist
    var endpoint: Endpoint {get set}
}
extension BaseRepositoryProtocol {
    var url : URL {
        let urlString = "\(baseURL)\(endpoint)\(key)"
        guard let url = URL(string: urlString) else {
            fatalError("Unable to get a url")
        }
        return url
    }
}

protocol LiveCurrencyRepositoryProtocol: class, BaseRepositoryProtocol {
    func fetchLiveCurrency(completionHandler: @escaping (CurrencyRate) -> ())
}

protocol ListCurrencyRepositoryProtocol: class, BaseRepositoryProtocol {
    func fetchListOfCurrency(completionHandler: @escaping (CurrencyList) -> ())
}

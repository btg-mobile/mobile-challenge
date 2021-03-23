//
//  CurrencyLayerAPI.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 22/03/21.
//

import Foundation

final class CurrencyLayerAPI {
    
    private static let base = "https://api.currencylayer.com/"
    private static let accessKey = "5fce2e7a8a6676ece9540533be7e3daf"
    static let supportedCurrenciesURL = base + "list" + "?access_key=" + accessKey
    static let realTimeRatesURL = base + "live" + "?access_key=" + accessKey

    static let shared = CurrencyLayerAPI()
    private init() { }
    
    func fetchSupportedCurrencies(completion: @escaping () -> Void) {
        guard let url = URL(string: CurrencyLayerAPI.realTimeRatesURL) else {
            preconditionFailure("Not a URL")
        }
        Debugger.log("REQUEST: ",url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            Debugger.log(data ?? "aa")
            Debugger.log(response ?? "bb")
            Debugger.log(error ?? "cc")
            completion()
        }.resume()
    }
}

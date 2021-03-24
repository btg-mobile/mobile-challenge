//
//  CurrencyLayerAPI.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 22/03/21.
//

import Foundation

final class CurrencyLayerAPI {
    private static let base = "http://api.currencylayer.com/"
    private static let accessKey = "5fce2e7a8a6676ece9540533be7e3daf"
    private static let supportedCurrenciesURL = base + "list?access_key=" + accessKey
    private static let realTimeRatesURL = base + "live?access_key=" + accessKey

    static let shared = CurrencyLayerAPI()
    private init() { }
    
    func fetchSupportedCurrencies(completion: @escaping ([Currency]?) -> Void) {
        guard let url = URL(string: CurrencyLayerAPI.supportedCurrenciesURL) else {
            preconditionFailure("Unable to construct URL")
        }
        Debugger.log("OUTGOING: ",url)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let currenciesDTO = try decoder.decode(CurrenciesDTO.self, from: data)
                    completion(currenciesDTO.currencies)
                } catch {
                    Debugger.log(error)
                }
            } else {
                // TODO: Error handling
                Debugger.log("Response came with no data")
            }
            completion(nil)
        }.resume()
    }
    
    func fetchConversions(completion: @escaping ([Conversion]?) -> Void) {
        guard let url = URL(string: CurrencyLayerAPI.realTimeRatesURL) else {
            preconditionFailure("Unable to construct URL")
        }
        Debugger.log("OUTGOING: ",url)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        print(jsonResult)
                    }
                    let decoder = JSONDecoder()
                    let conversionsDTO = try decoder.decode(ConversionsDTO.self, from: data)
                    completion(conversionsDTO.conversions)
                } catch {
                    Debugger.log(error)
                }
            } else {
                // TODO: Error handling
                Debugger.log("Response came with no data")
            }
            completion(nil)
        }
        task.resume()
    }
}
